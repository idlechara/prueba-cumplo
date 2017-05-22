require "selenium-webdriver"

cap = Selenium::WebDriver::Remote::Capabilities.chrome(:ignoreProtectedModeSettings=>true,:ignoreZoomSetting=>true,:unexpectedAlertBehaviour=>"ignore")
driver = Selenium::WebDriver.for :remote, url: "http://127.0.0.1:4444/wd/hub", desired_capabilities: cap

# Test RECC webpage
## Break login! <3
driver.navigate.to "https://palena.sii.cl/rtc/RTC/RTCConsultas.html"
wait = Selenium::WebDriver::Wait.new(timeout: 0.1) # seconds
wait.until { driver.find_element(id: "rutcntr") }

driver.find_element(id: 'rutcntr').send_keys "***REMOVED***"
driver.find_element(id: 'clave').send_keys "***REMOVED***"
driver.find_element(id: 'clave').submit

## Get the info and run
driver.find_element(name: 'rut_emisor').send_keys "00000000"
driver.find_element(name: 'dv_emisor').send_keys "8"
driver.find_element(name: 'folio').send_keys "233"

#### Extract all options from the select box
options=driver.find_element(name: 'tipo_docto').find_elements(:tag_name => "option")
 
#### Select document type (33)
options.each do |g|
  if g.attribute("value") == "33"
    puts "found you"
    g.click
    break
  end
end

begin
    driver.execute_script("document.myform.action ='/cgi_rtc/RTC/RTCConsulta.cgi' ;valConsulta();")
    wait = Selenium::WebDriver::Wait.new(timeout: 0.1) # seconds
    wait.until { driver.find_element(xpath: "/html/body/table[2]/tbody/tr[3]/td/font/b") }
    result = driver.find_element(xpath: "/html/body/table[2]/tbody/tr[3]/td/font/b").text
    if(result.include? "Documento Cedido.")
        puts "Cedido ctm"
    end
    

rescue Selenium::WebDriver::Error::UnhandledAlertError
    puts(driver.switch_to.alert.text)
end

driver.quit