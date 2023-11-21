class A(a,b):
    a = 1
    b = 5
    c = 3
    d = 5
    if a>2:
        if b>10:
            print(b)
        elif b<10:
            print(c)
        print(a)
    if b<2:
        print(b)
    elif c<3:
        print(c)
    else:
        print(d)
    for i in range(1,2):
        for i in range(3,4):
            print(b)
        print(a)
    while a<4:
        print(a)
        a = a+1
    def add(a, b):
        result = a + b
        result = a - b
        result = a
        print("Hello World")
        return result
