import turtle
import random

def lt(t, angle):
    t.lt(angle)

def fd(t, num):
    t.fd(num)

def line_setting(): # 경주 트랙 그리기
    t = turtle.Turtle()
    t.pensize(2) # 트랙 선을 두껍게 그리기 위해 펜사이즈를 조절
    t.speed(0) # 선 그리는 시간을 단축하기 위해 사용함

    t.up()
    t.goto(0, 90) # 편의를 위해 x값을 0으로 잡음
    t.down()
    fd(t, 200)
    t.color("red")
    t.write("결승선", font = ("맑은고딕", 12, "bold"))
    lt(t, 90)
    fd(t, 100)
    lt(t, 90)
    t.color("black")
    fd(t, 200)
    lt(t, 90)
    t.pensize(5)
    fd(t, 100) # 출발선
    lt(t, 90)
    t.up()
    t.goto(t.xcor()-50, t.ycor())
    t.write("출발선", font = ("맑은고딕", 12, "bold"))
    t.up()

    t.pensize(3)
    t.color("green")
    t.goto(0, 140)
    t.down()
    fd(t, 200)
    t.up()
    t.hideturtle() # t 모습 숨기기
    
def image_setting(): # 거북이와 토끼 이미지 적용하고 위치 조정
    t_rabbit.shape(img_rabbit)
    t_turtle.shape(img_turtle)

    t_rabbit.up()
    t_rabbit.speed(0)
    t_rabbit.goto(0, 110)

    t_turtle.up()
    t_turtle.speed(0)
    t_turtle.goto(0, 150)

def start():
    while True: # 무한반복
        turtle_speed = random.randrange(0, 10)
        rabbit_speed = random.randrange(0, 10)

        turtle_x = t_turtle.xcor()
        rabbit_x = t_rabbit.xcor()
        # 현재 x좌표값 가져오기

        t_turtle.setx(turtle_x + turtle_speed)
        t_rabbit.setx(rabbit_x + rabbit_speed)
        # 기존 x값에 난수를 더해 x값 증가

        if turtle_x > rabbit_x:
            text.clear()
            text.write("거북이가 더 빠르게 나아가고 있습니다.", font = ("맑은고딕", 12, "bold"))
        elif rabbit_x > turtle_x:
            text.clear()
            text.write("토끼가 더 빠르게 나아가고 있습니다.", font = ("맑은고딕", 12, "bold"))
        else:
            text.clear()
            text.write("토끼와 거북이가 동점을 유지하고 있습니다.", font = ("맑은고딕", 12, "bold"))
            # text 터틀을 계속 clear하기 때문에 매번 font를 설정해줌

        if turtle_x >= 185 or rabbit_x >= 185:
            # 경주라인의 길이는 200이지만
            # 이미지(32*32px를 사용함)에 맞춰
            # 결승 도착 값을 >= 200이 아닌 >= 185로 잡음
            if turtle_x > rabbit_x:
                text.clear()
                text.color("red")
                text.write("거북이가 승리했습니다", font = ("맑은고딕", 12, "bold"))
            elif turtle_x < rabbit_x:
                text.clear()
                text.color("red")
                text.write("토끼가 승리했습니다.", font = ("맑은고딕", 12, "bold"))
            else:
                text.clear()
                text.color("red")
                text.write("토끼와 거북이가 동시에 도착했습니다.", font = ("맑은고딕", 12, "bold"))
            break

# 토끼와 거북이 설정
t_rabbit = turtle.Turtle() # 토끼 터틀 객체
t_turtle = turtle.Turtle() # 거북이 터틀 객체

screen = turtle.Screen() # 스크린
img_rabbit = "c:\\python_workspace\\rabbit.gif" # 이미지 경로
img_turtle = "c:\\python_workspace\\turtle.gif" # 이미지는 하단에서 다운 받으세요.
screen.addshape(img_rabbit) # 터틀 객체에 토끼 이미지 적용
screen.addshape(img_turtle) # 터틀 객체에 거북이 이미지 적용

text = turtle.Turtle() # 텍스트를 작성할 터틀 생성
text.speed(0) # 터틀 속도
text.hideturtle() # 터틀 안보이게 설정
text.write("준비중입니다...", font = ("맑은고딕", 12, "bold"))
line_setting() # 경주 라인 설정 
image_setting() # 이미지 설정
text.clear() # 설정이 끝나면 작성한 텍스트 제거
text.color("Blue")

start()
