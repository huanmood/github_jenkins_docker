import logging
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options

chrome_options = Options()
chrome_options.binary_location = r"D:\google浏览器\chrome-win64\chrome.exe"

chrome_options.add_argument("--headless=new")
chrome_options.add_argument("--window-size=1920,1080")

chrome_driver_path = r"D:\google浏览器\chromedriver.exe"

service = Service(executable_path=chrome_driver_path)

try:
    driver = webdriver.Chrome(service=service, options=chrome_options)
    print("浏览器启动成功")
except Exception as e:
    print("启动失败:", e)
    exit()

driver.get("https://www.google.com")
print("标题:", driver.title)

driver.quit()