import numpy as np
import pandas as pd
import time

#生成随机数
np.random.seed(2)

#设置全局变量，固定的属性
N_STATES=6 #起点到终点的距离
ACTIONS=['left','rigth'] #机器允许的动作，左右
EPSILON=0.9 #greedy police一个参数
ALPHA=0.1   #学习效率
LAMBDA=0.9    #未来奖励的衰减值
MAX_EPISODES=13 #最大的训练回合
FRESH_TIME=0.3  #每走一步所花费的时间

#初始化建立Q-table
def build_q_table(n_states,actions):
    #创建一张起点到终点距离的长度一样的表格，列为机器允许的动作
    table=pd.DataFrame(np.zeros((n_states,len(actions))),columns=actions)
    return table

# build_q_table(N_STATES,ACTIONS)

#初始化机器的动作功能
#根据当前的状态和q_table的值来选择下一步的动作
def choose_action(state,q_table):
    #选取q_table的第几行
    state_actions=q_table.iloc[state,:]
    #当生成的随机数的值大于0.9时候，或者q_table一整行全为0的时候随机选取left或者right
    if (np.random.uniform()>EPSILON) or (state_actions.all()==0):
        action_name=np.random.choice(ACTIONS)
    else:
        #当不满足上述条件的时候，将q_table的较大的那个数字选择出来
        action_name=state_actions.argmax()
    return action_name

#初始化反馈
def get_env_feedback(S,A):
    if A=='right':
        if S==N_STATES-2:
            S_='terminal'
            R=1
        else:
            S_=S+1
            R=0
    else:
        R=0
        if S==0:
            S_=S
        else:
            S_=S-1
    return S_,R

#初始化环境
def update_env(S,episode,step_counter):
    env_list=['-']*(N_STATES-1)+['T']
    if S=='terminal':
        interaction='Episode %s: total_steps=%s'%(episode+1,step_counter)
        print('\r{}'.format(interaction),end='')
        time.sleep(2)
        print('\r              ',end="")
    else:
        env_list[S]='o'
        interaction=''.join(env_list)
        print('\r{}'.format(interaction),end="")
        time.sleep(FRESH_TIME)

#创建主循环
def rl():
    q_table=build_q_table(N_STATES,ACTIONS)
    for episode in range(MAX_EPISODES):
        step_counter=0
        S=0
        is_terminated=False
        update_env(S,episode,step_counter)
        while not is_terminated:
            A=choose_action(S,q_table)
            S_,R=get_env_feedback(S,A)
            q_predict=q_table.loc[S,A]
            if S_!='terminal':
                q_target=R+LAMBDA*q_table.iloc[S_,:].max()
            else:
                q_target=R
                is_terminated=True
            q_table.loc[S,A]=q_table.loc[S,A]+ALPHA*(q_target-q_predict)
            S=S_
            update_env(S,episode,step_counter+1)
            step_counter=step_counter+1
    return q_table

if __name__ == "__main__":
    q_table=rl()
    print('r\n\Q-table:\n')
    print(q_table)
