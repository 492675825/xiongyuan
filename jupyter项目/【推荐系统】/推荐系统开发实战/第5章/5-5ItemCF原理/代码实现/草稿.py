import pandas as pd
import numpy as np
import json

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
        itemSim ={}
        #物品用户矩阵
        item_user_count ={}
        #同现矩阵
        count ={}
        #物品用户数量矩阵实现
        for user, item in self.user_score_dict.items():
            for i in item.keys():
                item_user_count.setdefault(i,0)
                if self.user_score_dict[user][i] > 0.0:
                    item_user_count[i] += 1
                #同现矩阵实现
                for j in item.keys():
                    count.setdefault(i, {}).setdefault(j,0)
                    if(
                        self.user_score_dict[user][i] > 0.0
                        and self.user_score_dict[user][j] > 0.0
                        and i !=j
                    ):
                        count[i][j] +=1

        json.dump(count,open('./count.json','w'))
        data = pd.read_json('./count.json')
        return data




if __name__ == '__main__':
    ib = ItemCF()
    print(ib.ItemSimilarity())


