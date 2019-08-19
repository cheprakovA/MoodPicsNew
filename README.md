# MoodPicsNew

## Скриншоты 
![](https://i.ibb.co/0ZkQhJW/OW0-MXne-KZQ4.jpg)
![](https://i.ibb.co/jR5tbQm/Qks1-Q-3bch-A.jpg)
![](https://i.ibb.co/NN65MmS/Tkr-C2-Zlzs-Zs.jpg)
![](https://i.ibb.co/X5NjbQZ/wj-MBb-MJ2l-EE.jpg)

## Описание

Приложение было написано во врем обучения в летней школе Surf iOS.

Приложение определяет общее настроение изображения, и, используя предобученную модель ML подбирает подходящие картинки. В качестве провайдера пикч используется [Unsplash API](https://unsplash.com). На данном этапе у приложения нет ни одной зависимости от сторонних библиотек, однако для установки необходимо скачать [саму модель](https://drive.google.com/file/d/0B1ghKa_MYL6mZ0dITW5uZlgyNTg/view) и добавить ее в ресурсы проекта. 

## Реализация 

+ пока что, основная реализация UI: storyboard + autolayout
+ навигация: ```UITabBarController```
+ [CustomLayout.swift](https://github.com/cheprakovA/MoodPicsNew/blob/master/MoodPics/Library/Extensions/CustomLayout.swift) - был подглянут с Pinterest'а 

## Дальше:

+ привести в порядок код, возможно подсмотрев что-то в сторонних решениях
+ добавить кеширование картинок и авторизацию через Unsplash аккаунт
