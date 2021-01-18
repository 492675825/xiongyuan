import pandas as pd
import numpy as np
import math
import os
import json
import random

class ItemCFRec:
    def __init__(self, datafile, ratio):
        # 原始数据
        self.datafile = datafile
        # 测试集与训练集的比例
        self.ratio = ratio

        self.data = self.loadData()
        self.trainData ,self.testData = self.splitData(3 ,47)
        # self.item_sim = self.ItemSimilarityBest()

        # 加载评分数据到data
    def loadData(self):
        print('加载数据...')
        data = []
        for line in open(self.datafile):
            userid ,itemid ,record , _= line.split('::')
            data.append((userid ,itemid ,int(record)))
        return data

    '''
        拆分数据集为训练集和测试集
        k:参数
        seed:生成随机数的种子
        M:随机数上限
    '''

    def splitData(self ,k ,seed ,M=9):
        print('训练集与测试集切分...')
        train, test = {}, {}
        random.seed(seed)
        for user, item, record in self.data:
            if random.randint(0 ,M) ==k:
                test.setdefault(user, {})
                test[user][item] = record
            else:
                train.setdefault(user, {})
                train[user][item] = record
        return train ,test

    # 计算物品之间的相似度
    def ItemSimilarityBest(self):
        print('开始计算物品之间的相似度')
        if os.path.exists('./item_sim.json'):
            print('物品相似度从文件加载....')
            itemSim = json.load(open('./item_sim.json' ,'r'))
        else:
            itemSim = dict()
            item_user_count = dict()  # 得到每个物品有多少用户产生行为
            count = dict()  # 同现矩阵
            for user, item in self.trainData.items():
                print('user is {}'.format(user))
                for i in item.keys():
                    item_user_count.setdefault(i ,0)
                    if self.trainData[str(user)][i] > 0.0:
                        item_user_count[i] = item_user_count[i] + 1
                    for j in item.keys():
                        count.setdefault(i ,{}).setdefault(j ,0)
                        if self.trainData[str(user)][i] > 0.0 \
                                and self.trainData[str(user)][j] > 0.0 and i != j:
                            count[i][j] = count[i][j] + 1
                    # 同现矩阵-> 相似度矩阵
                    for i ,related_items in count.items():
                        itemSim.setdefault(i ,dict())
                        for j, cuv in related_items.items():
                            itemSim[i].setdefault(j ,0)
                            itemSim[i][j] = cuv / math.sqrt(item_user_count[i] *item_user_count[j])
        json.dump(itemSim, open('./item_sim.json' ,'w'))
        return itemSim

    '''
        为用户进行推荐
        user:用户
        K：K个临近物品
        nitem:总共返回n个物品
    '''

    def recommend(self, user, k=8, nitems=40):
        result = dict()
        u_items = self.trainData.get(user, {})
        for i, pi in u_items.items():
            for j, wj in sorted(self.items_sim[i].items(), key=lambda x :x[1], reverse=True)[0:k]:
                if j in u_items:
                    continue
                result.setdefault(j ,0)
                result[j ] =result[j] +pi *wj
        return dict(sorted(result.items(), key=lambda x :x[1], reverse=True)[0:nitems])

if __name__ == '__main__':
    ib = ItemCFRec(r'C:\Users\xiongyuan\Desktop\xiongyuan\jupyter项目\【推荐系统】\MovieLens & kaggle\recommed01\ratings.dat',[1,9])
