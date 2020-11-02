class bank:
    def __init__(self,name,age,sex):
        self.name=name
        self.age=age
        self.sex=sex
    
    def eat(self):
        print(self.name,"想吃宵夜")
    
    def run(self):
        print(self.name,"今年",self.age,"岁","性别为：",self.sex)

    def code(self,num):
        num=1 
        print(self.name,"计算结果为：",num)
