import logging
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options

chrome_options = Options()
chrome_options.add_argument("--headless=new")
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")
chrome_options.add_argument("--window-size=1920,1080")

service = Service("/usr/bin/chromedriver")

driver = webdriver.Chrome(service=service, options=chrome_options)

driver.get("https://www.google.com")
print("标题:", driver.title)

driver.quit()