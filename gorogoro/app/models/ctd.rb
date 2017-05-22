require "selenium-webdriver"

class Ctd < ApplicationRecord
  belongs_to :sender, :class_name => "Taxpayer", :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => "Taxpayer", :foreign_key => 'recipient_id'

  def validate_document!
    if self.status == "Cedido"
      return
    else
      [33, 34, 43, 46].each do |doctype|
        validate_against_sii(doctype)
        if(self.status == "Cedido")
          break
        end
      end
    end
    self.save
  end

  private

  def validate_against_sii(doctype)
    puts "Calling back!"
    cap = Selenium::WebDriver::Remote::Capabilities.chrome(:ignoreProtectedModeSettings=>true,:ignoreZoomSetting=>true,:unexpectedAlertBehaviour=>"ignore")
    driver = Selenium::WebDriver.for :remote, url: "http://127.0.0.1:4444/wd/hub", desired_capabilities: cap

    # Test RECC webpage
    ## Break login! <3
    driver.navigate.to "https://palena.sii.cl/rtc/RTC/RTCConsultas.html"
    wait = Selenium::WebDriver::Wait.new(timeout: 0.1) # seconds
    wait.until { driver.find_element(id: "rutcntr") }

    ## Login as someone
    driver.find_element(id: 'rutcntr').send_keys Rails.application.config.sii_username
    driver.find_element(id: 'clave').send_keys Rails.application.config.sii_password
    driver.find_element(id: 'clave').submit

    ## Get the info and run
    rut, dv = self.sender.rut.split(/-/)
    driver.find_element(name: 'rut_emisor').send_keys rut
    driver.find_element(name: 'dv_emisor').send_keys dv
    driver.find_element(name: 'folio').send_keys self.folio

    #### Extract all options from the select box
    options=driver.find_element(name: 'tipo_docto').find_elements(:tag_name => "option")

    #### Select document type (33)
    options.each do |g|
      if g.attribute("value") == doctype
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
        self.status = "Cedido"
        puts("Hiss")
      end


    rescue Selenium::WebDriver::Error::UnhandledAlertError
      # puts(driver.switch_to.alert.text)
      if(driver.switch_to.alert.text.include? "Documento consultado no existe o no ha sido cedido.")
        self.status = "No Cedido"
      end
    end

    driver.quit
  end
end
