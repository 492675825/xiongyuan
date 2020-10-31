import pandas as pd 
import numpy as np

data=list([[1,2,3],[4,4,6],[7,8,9],[10,11,12]]);
data=pd.DataFrame(data);
data.columns=["name","age","class"];

def join(df_col_name):
    df_list=[]
    for col in df_col_name:
        df_list.append(str(col))
    df_join_list=",".join(df_list)
    return df_join_list

agg_dict={
    "name":join(data["name"]),
    "age":join(data["age"]),
    "class":join(data["class"])
}

user_log_path=data.groupby("name").agg(agg_dict)

print(data)
print(user_log_path)
