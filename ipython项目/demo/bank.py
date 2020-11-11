class bank:

    def __init__(self):
        self.__id = "0001";
        self.__password = "123456";
        self.__balance = 10000;

    def get_id(self):
        return self.__id;

    def get_password(self):
        return self.__password;

    def set_password(self, password):
        self.__password = password;

    def get_balance(self):
        return self.__balance;

    def begin(self):
        while 1 == 1:
            user_id = input("请输入银行卡号");
            password = input("请输入银行卡密码");
            if user_id=="0001":
                if password=="123456":
                    print("登入成功，请选择交易类型");
                    print("1、存款");
                    print("2、取款");
                    print("3、修改交易密码");
                    print("4、退出");
                    chose = input("请选择交易类型");
                    if chose=="4":
                        break;
                    elif chose=="1":
                        bank.cun();
                    elif chose=="2":
                        bank.qu();
                    
            else:
                print("登入失败");
                break;
        
    def cun(self):
        num=int(input("请输入交易金额"));
        self.__balance=self.__balance+num;
        print("存款成功，卡上余额:",self.__balance,"元");

    def qu(self):
        num=int(input("请输入取款金额"));
        self.__balance=self.__balance-num;
        print("取款成功，当前卡上余额：",self.__balance,"元");

    def mima(self):
        pass



if __name__ == "__main__":
    bank=bank();
    bank.begin();
    
