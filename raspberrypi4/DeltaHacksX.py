#!/usr/bin/env python3
import RPi.GPIO as GPIO             
from time import sleep
import pyrebase
import os
import pygame
import random
            
config = {     
  "apiKey": "SgoPRPVAT7deLJAdADSItM0E2y3SUcEU3U8bYvbc",
  "authDomain": "bitebox-79d22.firebaseapp.com",
  "databaseURL": "https://bitebox-79d22-default-rtdb.firebaseio.com/",
  "storageBucket": "bitebox-79d22.appspot.com"
}

firebase = pyrebase.initialize_app(config)

redLED = 12				
blueLED = 19            
greenLED = 18
servo1 = 4
servo2 = 7

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(redLED,GPIO.OUT)    
GPIO.setup(blueLED,GPIO.OUT)   
GPIO.setup(greenLED,GPIO.OUT)
GPIO.setup(servo1,GPIO.OUT) 
GPIO.setup(servo2,GPIO.OUT)   

red_pwm = GPIO.PWM(redLED,1000)
blue_pwm = GPIO.PWM(blueLED,1000) 
green_pwm = GPIO.PWM(greenLED,1000)
servo1_pwm = GPIO.PWM(servo1, 50)
servo2_pwm = GPIO.PWM(servo2, 50)

red_pwm.start(0)			
blue_pwm.start(0)                       
green_pwm.start(0)
servo1_pwm.start(0)
servo2_pwm.start(0)

def red_LED():
    red_pwm.ChangeDutyCycle(100)
    blue_pwm.ChangeDutyCycle(0)
    green_pwm.ChangeDutyCycle(0)
    
def blue_LED():
    red_pwm.ChangeDutyCycle(0)
    blue_pwm.ChangeDutyCycle(100)
    green_pwm.ChangeDutyCycle(0)

def green_LED():
    red_pwm.ChangeDutyCycle(0)
    blue_pwm.ChangeDutyCycle(0)
    green_pwm.ChangeDutyCycle(100)
    
def power_Off_LED():
    red_pwm.ChangeDutyCycle(0)
    blue_pwm.ChangeDutyCycle(0)
    green_pwm.ChangeDutyCycle(0)
    
def open_Box():
    servo1_pwm.ChangeDutyCycle(7.5)
    servo2_pwm.ChangeDutyCycle(7.5)

def close_Box():
    servo1_pwm.ChangeDutyCycle(2.5)
    servo2_pwm.ChangeDutyCycle(2.5)
   
def play_sound(sound):
    pygame.mixer.init()
    pygame.mixer.music.load(sound)
    pygame.mixer.music.play()
    while pygame.mixer.music.get_busy():
        pygame.time.Clock().tick(10)
    
dict = {
    "cold": "ice-ice-baby.mp3",
    #"neutral": "",
    "hot": ["hot-hot-hot.mp3", "ah-thats-hot.mp3"],
    "open": "fbi-open-up.mp3"
    #"close": ""
}

try:
    while True:
        db = firebase.database()
        collection_name= "box"
        temperature = db.child(collection_name).child("temperature").get().val()
        isOpen = db.child(collection_name).child("isOpen").get().val()
        isFull = db.child(collection_name).child("isFull").get().val()
        
        played_toggle = 0
        
        if isOpen == 1:
            open_Box()
            sound = dict["open"]
            if isinstance(sound, list):
                sound = random.choice(sound)
                if played_toggle == 0:
                    play_sound(sound)
                    play_toggle = 1
            
            #sleep(0.5)
            
        elif isOpen == 0:
            close_Box()
            #sleep(0.5)
            
        print("lol")
        
        if isFull == 1:
            print("hi")
            if temperature == -1:
                blue_LED()
                sound = dict["cold"]
                play_sound(sound)
            elif temperature == 0:
                green_LED()
            elif temperature == 1:
                red_LED()
                sound = random.choice(dict["hot"])
                play_sound(sound)
            #sleep(0.5)
                
        elif isFull == 0:
            power_Off_LED()
            #sleep(0.5)
            
        sleep(0.5)

except KeyboardInterrupt: 		
    pass
    
finally:
    red_pwm.stop() 			
    blue_pwm.stop() 
    green_pwm.stop()
    servo1_pwm.stop()
    servo2_pwm.stop()
    GPIO.cleanup()