import pandas as pd
import numpy as np

#创建一个数据集，方便之后的项目调用
def createDataSet():
    group=np.array([1.0,1.1],[1.0,1.0],[0,0],[0,0.1])
    labels=["A","A","B","B"]
    return group,labels