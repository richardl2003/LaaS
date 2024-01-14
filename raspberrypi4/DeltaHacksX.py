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

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(redLED,GPIO.OUT)    
GPIO.setup(blueLED,GPIO.OUT)   
GPIO.setup(greenLED,GPIO.OUT)
GPIO.setup(servo1,GPIO.OUT)  

red_pwm = GPIO.PWM(redLED,1000)
blue_pwm = GPIO.PWM(blueLED,1000) 
green_pwm = GPIO.PWM(greenLED,1000)
servo1_pwm = GPIO.PWM(servo1, 50)

red_pwm.start(0)			
blue_pwm.start(0)                       
green_pwm.start(0)
servo1_pwm.start(0)

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

def close_Box():
    servo1_pwm.ChangeDutyCycle(2.5)
   
def play_sound(sound):
    pygame.mixer.init()
    pygame.mixer.music.load(sound)
    pygame.mixer.music.play()
    while pygame.mixer.music.get_busy():
        pygame.time.Clock().tick(10)
        
def temperature_led(temperature):
        if temperature == -1:
            blue_LED()
            sleep(1)
        elif temperature == 0:
            green_LED()
            sleep(1)
        else:
            red_LED()
            sleep(1)
            
def temperature_led_with_sound(temperature):
        if temperature == -1:
            blue_LED()
            sleep(1)
            sound = dict["cold"]
            play_sound(sound)
        elif temperature == 0:
            green_LED()
            sleep(1)
        elif temperature == 1:
            red_LED()
            sleep(1)
            sound = random.choice(dict["hot"])
            play_sound(sound)
    
dict = {
    "cold": "ice-ice-baby.mp3",
    "hot": ["ah-thats-hot.mp3"],
    "open": "fbi-open-up.mp3"
}

door_toggle = 0

try:
    while True:
        
        db = firebase.database()
        collection_name= "box"
        temperature = db.child(collection_name).child("temperature").get().val()
        isOpen = db.child(collection_name).child("isOpen").get().val()
        isFull = db.child(collection_name).child("isFull").get().val()
        
        if (isFull == 1 and isOpen == 1 and door_toggle == 0):
                door_toggle = 1
                open_Box()
                sleep(1)
                temperature_led(temperature)
                sound = dict["open"]
                play_sound(sound)

        elif (isFull == 1 and isOpen == 0):
                close_Box()
                sleep(1)
                temperature_led(temperature)
                door_toggle = 0
                
        elif (isFull == 0 and isOpen == 1 and door_toggle == 0):
                door_toggle = 1
                open_Box()
                sleep(1)
                temperature_led_with_sound(temperature)
                        
        elif (isFull == 0 and isOpen == 0):
                door_toggle = 0
                close_Box()
                sleep(1)
                power_Off_LED()
            
        sleep(1)
        

except KeyboardInterrupt: 		
    pass
    
finally:
    red_pwm.stop() 			
    blue_pwm.stop() 
    green_pwm.stop()
    servo1_pwm.stop()
    GPIO.cleanup()
