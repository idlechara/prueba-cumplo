require 'open-uri'

open("https://palena.sii.cl/cvc_cgi/dte/ee_consulta_empresas_dwnld?NOMBRE_ARCHIVO=ee_empresas_nomipyme.csv").each_line do |line|
  rut, business_name, resolution_number, resolution_date, approval_date, region = line.split(/;/)
  puts rut + " " + business_name
end