import math
import pandas as pd
import numpy as np

class ItemCF:
    def __init__(self):
        self.user_score_dict = self.initUserScore()
        self.items_sim = self.ItemSimilarity()

    # 初始化数据
    def initUserScore(self):
        user_score_dict = {
            "A": {"a": 3.0, "b": 4.0, "c": 0.0, "d": 3.5, "e": 0.0},
            "B": {"a": 4.0, "b": 0.0, "c": 4.5, "d": 0.0, "e": 3.5},
            "C": {"a": 0.0, "b": 3.5, "c": 0.0, "d": 0.0, "e": 3.0},
            "D": {"a": 0.0, "b": 4.0, "c": 0.0, "d": 3.5, "e": 3.0}
        }
        return user_score_dict

    #计算item之间的相似度
    def ItemSimilarity(self):
        #相似度矩阵
        itemSim = dict()
        #物品用户矩阵
        item_user_count = dict()
        #同现矩阵
        count = dict()
        #物品用户数量矩阵实现
        for user, item in self.user_score_dict.items():
            for i in item.keys():
                item_user_count.setdefault(i, 0)
                if self.user_score_dict[user][i] >0.0:
                    item_user_count[i] += 1
                #同现矩阵实现
                for j in item.keys():
                    count.setdefault(i, {}).setdefault(j,0)
                    if(
                        self.user_score_dict[user][i] >0.0
                        and self.user_score_dict[user][j] >0.0
                        and i !=j
                    ):
                        count[i][j] += 1
        #同现矩阵 -> 相似度矩阵
        for i, related_items in count.items():
            itemSim.setdefault(i, {})
            for j, cuv in related_items.items():
                itemSim[i].setdefault(j, 0)
                itemSim[i][j] = cuv / item_user_count[i]
        return itemSim

    #预测用户对item的评分
    def preUserItemScore(self, userA, item):
        score = 0.0
        #循环遍历相似度矩阵
        for item1 in self.items_sim[item].keys():
            if item1 !=item:
                score +=(self.items_sim[item][item1] * self.user_score_dict[userA][item1])
        return score

    #为用户推荐物品
    def recommend(self, userA):
        #计算userA未评分item的可能评分
        user_item_score_dict ={}
        for item in self.user_score_dict[userA].keys():
            user_item_score_dict[item] = self.preUserItemScore(userA, item)
        return user_item_score_dict

if __name__ == '__main__':
    ib= ItemCF()
    print(ib.recommend('C'))




