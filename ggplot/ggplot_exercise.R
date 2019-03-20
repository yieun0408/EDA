################
# ggplot2 연습 #
################
library(ggplot2)
library(tidyverse)
data(mpg)

#qplot
qplot(displ, hwy, data = mpg)
#qplot은 quick plot의 약자. 말그대로 빠르게 이차원 그래프를 그려준다.
#순서대로 x, y가 들어간다

ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))
#ggplot을 사용해 위 qplot과 똑같은 그래프를 그려보자.
#geom_point는 점! 즉 산점도를 그리는 것이며, 
#aes는 매핑 시켜주는 것! x와y는 생략 가능하며 순서대로 적으면 알아서 x와 y로 인식한다.

ggplot(data=mpg, aes(displ, hwy)) +
  geom_point()
#이렇게 그려도 옦케이! ~^^~

#정리를 하자면, 처음 ggplot(aes(x,y))에 들어가는 aes는 x축과 y축을 설정해 주는 것이라고 보면된다.
#그 뒤에 +를 해서 원하는 그래프를 만들수 있는데,
#geom_point, geom_bar 등 다양한 geom을 설정할 수 있다!
#geom안에 들어가는 aes는 지오메트릭 요소에 데이터를 매핑해주는 것이다.

#alpha: 흐리게!
ggplot(data = mpg) +
  geom_point(mapping = aes(displ, hwy, color = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(displ, hwy, color = class, alpha=class))

ggplot(data = mpg) +
  geom_point(mapping = aes(displ, hwy, color = "black", alpha=class))

#shape: 모양 바꾸기
ggplot(data = mpg) +
  geom_point(mapping = aes(displ, hwy, color = class, shape=class))

#size: 크기 바꾸기
ggplot(data = mpg) +
  geom_point(mapping = aes(displ, hwy, color = class, size=class))

#facet_grid
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_grid(drv~cyl) #y축~x축 이2개 변수로 구분하여 플롯을 나눠그려라

#facet_wrap:2줄로 고정!
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_wrap(~class, nrow=2)


ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point() +
  facet_wrap(~class, nrow=2)

#smooth: 유연하게 - 회색 테두리 같은게 생김
#smooth(se=F) 하면, 뒤에 회색테두리 사라짐!
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point() +
  geom_smooth()


##jitter: geom_point(position = "jitter") 뭉치게 그려라
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(position = "jitter") + 
  geom_smooth()

#coord_flip: x축 y축 변환
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point() +
  coord_flip()

#####퀴즈!
ggplot(mpg, aes(displ, hwy)) +
  geom_smooth() +
  geom_point(aes(color = drv))


install.packages("gcookbook")
library(gcookbook)

data("tophitters2001")
tophit = tophitters2001[1:25,]

ggplot(tophit, aes(x=reorder(name, avg), avg)) +
  geom_point(size=3) +
  theme_bw() +
  theme(axis.text = element_text(angle = 60, hjust = 1),
        panel.grid.major.y = element_blank())

ggplot(tophit, aes(x=reorder(name, avg), avg)) +
  geom_point(size=3) +
  theme_bw() +
  theme(axis.text = element_text(angle = 60, hjust = 1),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank())
#panel.grid.minor.y = element_blank() 추가 할 때마다 y축 선이 사라짐!

ggplot(tophit, aes(x=reorder(name, avg), avg)) +
  geom_point(size=3) +
  theme_bw() +
  theme(axis.text = element_text(angle = 60, hjust = 1),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_line(colour = "gray60", linetype = "dashed"))
#x축 그리드 설정하니까, 회색의 점선 라인이 생김!!!

#결론: panel.grid는 뒷 배경 격자 선과 관련이 있고, 없애고 선 및 색깔 바꾸기가 가능


#####두두둥!!!!AL, NL 나눠서 그려보자!
#geom_segment: 점부터 선까지 이어줌
#scale_colour_brewer: 색 관련 옵션! NL과 AL을 나눠서 칠해라/
#guide=FALSE 범례표시 안해
#facet_grid(lg~., scales = "free_y", space = "free_y") 면분할
#=이제 핵심인듯! lg기준으로(y축에 놓구 해라)

#facet_grid()함수의 인수인 scales는 디폴트 값으로 
#“fixed”를 가지며 이때에는 분할된 면 마다 x축 변수, y축변수가 모두 나타난다. 
#“free_x”인 경우 x축 변수가 면에 따라 다르게 나타나며 
#“free_y”인 경우 y축 변수가 면에 따라 다르게 나타난다. 
#“free”인 경우 x축변수, y축변수가 모두 면에 따라 다르게 나타난다. 
#이 예에서와 같이 “free_y”를 사용하면 각 면마다 포함되어 있는 y변수만 나타나지만 
#각 면의 크기는 같다.
#aka 공간활용의 크기를 설정하는 옵션

ggplot(tophit, aes(avg, name)) +
  geom_segment(aes(yend=name), xend=0, colours="gray50") +
  geom_point(size=3, aes(colour=lg)) +
  scale_colour_brewer(palette = "Set1", limits=c("NL", "AL"), guide=FALSE) +
  theme_bw()+
  theme(panel.grid.major.y = element_blank()) + #뒤에 격자 그리드 없앨래
  facet_grid(lg~., scales = "free_y", space = "free_y")

#비교
ggplot(tophit, aes(avg, name)) +
  geom_segment(aes(yend=name), xend=0, colours="gray50") +
  geom_point(size=3, aes(colour=lg)) +
  scale_colour_brewer(palette = "Set1", limits=c("NL", "AL"), guide=FALSE) +
  theme_bw()+
  theme(panel.grid.major.y = element_blank()) 

ggplot(mpg, aes(class,hwy)) +
  geom_boxplot()+
  coord_flip()

#일반 박스 플롯 notch=T 허리 쪼매겠다 Y~X인점 주의!
boxplot(mpg$hwy~mpg$class, notch=T, col="yellow")

#mosaicplot: 한줄한줄 다르게 색칠
data("diamonds")
mosaicplot(~cut+clarity, data=diamonds, color=c("grey", "red"))

#일변량 bar차트!
ggplot(data=diamonds)+
  geom_bar(aes(x=cut))

#위에랑 동일! 일변량 bar차트
ggplot(data=diamonds)+
  stat_count(aes(x=cut))

#y=..prop.. 일변량이긴 한데, 비율로 표현!!!!카운트 말고!
#group 1  더미 만들어 주겠다
ggplot(data=diamonds)+
  geom_bar(aes(x=cut, y=..prop.., group=1))

#group안하면 이렇게 됨
#the proportion is calculated with respect to the data 
#that contains that field and is ultimately going to be 100%
ggplot(data=diamonds)+
  geom_bar(aes(x=cut, y=..prop..))

#cut마다 색깔 넣어줌! 이쁘다
ggplot(data=diamonds) +
  geom_bar(aes(x=cut, fill=cut))

#clarity를 bar안에 넣어줌
ggplot(data=diamonds) +
  geom_bar(aes(x=cut, fill=clarity))

#position = "dodge" 
#position은 막대의 위치를 의미합니다. 
#dodge는 복수의 데이터를 독립적인 막대 그래프로 나란히 표현할 때 사용합니다.
#즉, position='dodge'는 막대의 위치를 개별적인 막대로 나란히 표현하라는 명령어
#단, 나란히 표시할 막대의 데이터를 fill 혹은 color 함수를 이용해 반드시 구분
ggplot(data=diamonds) +
  geom_bar(aes(x=cut, fill=clarity), position = "dodge")

#coord_polar() 파이차트로! 근데 왜....??그냥 파이차트 만듬 안되나???
ggplot(data=diamonds) +
  geom_bar(aes(x=cut, fill=cut)) +
  coord_polar()

