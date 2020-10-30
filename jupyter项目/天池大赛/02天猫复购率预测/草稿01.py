import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
import warnings
import copy
import gc
from collections import Counter

warnings.filterwarnings("ignore")

pd.set_option("display.max_column",100)
pd.set_option("expand_frame_repr",False)

all_data_test=pd.read_csv(r"C:\Users\xiongyuan\Desktop\all_data_test.csv")


# 不同行为的业务函数定义
def col_cnt_(df_data, columns_list, action_type):
    try:
        data_dict = {}

        col_list = copy.deepcopy(columns_list)
        if action_type != None:
            col_list += ['action_type_path']

        for col in col_list:
            data_dict[col] = df_data[col].split(' ')

        path_len = len(data_dict[col])

        data_out = []
        for i_ in range(path_len):
            data_txt = ''
            for col_ in columns_list:
                if data_dict['action_type_path'][i_] == action_type:
                    data_txt += '_' + data_dict[col_][i_]
            data_out.append(data_txt)

        return len(data_out)
    except:
        return -1


# def col_nuique_(df_data, columns_list, action_type):
#     try:
#         data_dict = {}
#
#         col_list = copy.deepcopy(columns_list)
#         if action_type != None:
#             col_list += ['action_type_path']
#
#         for col in col_list:
#             data_dict[col] = df_data[col].split(' ')
#
#         path_len = len(data_dict[col])
#
#         data_out = []
#         for i_ in range(path_len):
#             data_txt = ''
#             for col_ in columns_list:
#                 if data_dict['action_type_path'][i_] == action_type:
#                     data_txt += '_' + data_dict[col_][i_]
#             data_out.append(data_txt)
#
#         return len(set(data_out))
#     except:
#         return -1


def user_col_cnt(df_data, columns_list, action_type, name):
    df_data[name] = df_data.apply(lambda x: col_cnt_(x, columns_list, action_type), axis=1)
    return df_data


# def user_col_nunique(df_data, columns_list, action_type, name):
#     df_data[name] = df_data.apply(lambda x: col_nuique_(x, columns_list, action_type), axis=1)
#     return df_data

# 点击次数
all_data_test = user_col_cnt(all_data_test,  ['seller_path'], '0', 'user_cnt_0')
# 加购次数
all_data_test = user_col_cnt(all_data_test,  ['seller_path'], '1', 'user_cnt_1')
# 购买次数
all_data_test = user_col_cnt(all_data_test,  ['seller_path'], '2', 'user_cnt_2')
# 收藏次数
all_data_test = user_col_cnt(all_data_test,  ['seller_path'], '3', 'user_cnt_3')
# # 不同店铺个数
# all_data_test = user_col_nunique(all_data_test,  ['seller_path'], '0', 'seller_nunique_0')
# 点击次数
all_data_test = user_col_cnt(all_data_test,  ['seller_path', 'item_path'], '0', 'user_cnt_0')

# 不同店铺个数
# all_data_test = user_col_nunique(all_data_test,  ['seller_path', 'item_path'], '0', 'seller_nunique_0')

# if __name__ == '__main__':
#     print(all_data_test)