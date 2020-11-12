class A:
    def __init__(self,name):
        self._name=name;
    
    @property
    def name(self):
        return self._name
    
    @name.setter
    def name(self,name):
        self._name=name;


def say_hello(obj):
    print('你好 %s'%obj.name)

b=A("孙悟空");
say_hello(b);


