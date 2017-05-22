# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[Taxpayer, Ctd].each(&:delete_all)
#
#

## I wanted to use faker for this but, since I can fetch all info form SII... Whatever <3
## Here you can add your datasources for taxpayers
## Be careful, since SII is prone to mess up with SSL sometimes. If that happens here, then all will be broken
datasources = [
    "https://palena.sii.cl/cvc_cgi/dte/ee_consulta_empresas_dwnld?NOMBRE_ARCHIVO=ee_empresas_nomipyme.csv",
    "https://palena.sii.cl/cvc_cgi/dte/ee_consulta_empresas_dwnld?NOMBRE_ARCHIVO=ee_empresas_mipyme.csv",
    "https://palena.sii.cl/cvc_cgi/dte/ee_consulta_empresas_dwnld?NOMBRE_ARCHIVO=ee_empresas_fiscales.csv"
]

puts "Downloading Taxpayers from SII. Go and grab a coffee, this will take A WHILE (30 mins maybe as it is a full dump)"
thread_main = datasources.map do | source |
  Thread.new do
    ## Remove the comments on this block if you want to use more threads. :3
    ## My test indicates that with only thread level is enough. So, don't add more.
    # thread_count = []
    open(source).each_line do |line|

      # thread_sub = Thread.new do
        rut, business_name, resolution_number, resolution_date, approval_date, region = line.split(/;/)
        # puts "Adding new Taxpayer: " + business_name.force_encoding('iso-8859-1').encode('utf-8')
        t = Taxpayer.new
        t.rut = rut.force_encoding('iso-8859-1').encode('utf-8')
        t.business_name = business_name.force_encoding('iso-8859-1').encode('utf-8')
        t.region = region.force_encoding('iso-8859-1').encode('utf-8')
        t.save!
      # end

      # thread_count.push thread_sub
      #
      # if thread_count.length > 2
      #   thread_count.each do |th|
      #     th.join
      #   end
      # end

    end
  end
end

thread_main.each do |thread|
  # puts(thread)
  thread.join
end
puts "Taxpayers on DB! Now populating with some documents"
## Now populate existing documents
documents = [['027', '$2122960', '76.273.545-8', '76.177.621-5'],
            ['026', '$702100', '76.273.545-8', '76.177.621-5'],
            ['237', '$1785000', '76.273.545-8', '76.177.621-5'],
            ['234', '$2677500', '76.273.545-8', '76.177.621-5'],
            ['233', '$2677500', '76.273.545-8', '76.177.621-5'],
            ['232', '$3808000', '76.273.545-8', '76.177.621-5'],
            ['231', '$809200', '76.273.545-8', '76.177.621-5'],
            ['230', '$3808000', '76.273.545-8', '76.177.621-5'],
            ['178', '$1695750', '79.517.200-9', '76.177.621-5'],
            ['177', '$641265', '79.517.200-9', '76.177.621-5'],
            ['487', '$15621846', '79.517.200-9', '76.177.621-5'],
            ['296', '$54335404', '79.517.200-9', '76.177.621-5'],
            ['59', '$2376682', '79.517.200-9', '76.177.621-5'],
            ['494', '$15114695', '79.517.200-9', '76.177.621-5'],
            ['561612', '$249900', '79.517.200-9', '76.177.621-5'],
            ['563501', '$67045', '79.517.200-9', '76.177.621-5'],
            ['563639', '$392224', '79.517.200-9', '76.177.621-5'],
            ['563640', '$83538', '79.517.200-9', '76.177.621-5'],
            ['563641', '$501228', '79.517.200-9', '76.177.621-5'],
            ['563791', '$521458', '79.517.200-9', '76.177.621-5'],
            ['563792', '$76160', '79.517.200-9', '76.177.621-5'],
            ['564049', '$334152', '79.517.200-9', '76.177.621-5'],
            ['564050', '$652339', '79.517.200-9', '76.177.621-5'],
            ['564051', '$475500', '79.517.200-9', '76.177.621-5'],
            ['564052', '$53663', '79.517.200-9', '76.177.621-5'],
            ['564613', '$3042628', '79.517.200-9', '76.177.621-5'],
            ['564640', '$134732', '79.517.200-9', '76.177.621-5'],
            ['564641', '$631165', '79.517.200-9', '76.177.621-5'],
            ['564642', '$646765', '79.517.200-9', '76.177.621-5'],
            ['565062', '$815424', '79.517.200-9', '76.177.621-5'],
            ['565066', '$507892', '79.517.200-9', '76.177.621-5'],
            ['565540', '$194506', '79.517.200-9', '76.177.621-5'],
            ['565547', '$43435', '79.517.200-9', '76.177.621-5'],
            ['565827', '$283118', '79.517.200-9', '76.177.621-5'],
            ['566309', '$285600', '79.517.200-9', '76.177.621-5'],
            ['566310', '$99960', '79.517.200-9', '76.177.621-5'],
            ['566317', '$139746', '79.517.200-9', '76.177.621-5'],
            ['566360', '$1107236', '79.517.200-9', '76.177.621-5'],
            ['567784', '$64260', '79.517.200-9', '76.177.621-5'],
            ['567785', '$4006', '79.517.200-9', '76.177.621-5'],
            ['567786', '$57122', '79.517.200-9', '76.177.621-5'],
            ['568131', '$15470', '79.517.200-9', '76.177.621-5'],
            ['568499', '$514080', '79.517.200-9', '76.177.621-5'],
            ['568500', '$5355', '79.517.200-9', '76.177.621-5'],
            ['62', '$6179500', '79.517.200-9', '76.177.621-5']]

documents.each do | doc |
  folio, amount, sender, reciever = doc
  # puts "Adding new Ctd: #" + folio + " " + sender
  c = Ctd.new
  c.folio = folio
  c.amount = amount.gsub!('$','')
  c.sender = Taxpayer.find_by_rut(sender.gsub!('.',''))
  c.recipient = Taxpayer.find_by_rut(reciever.gsub!('.',''))
  c.transfer_timestamp = Time.now.utc.iso8601
  c.status = "Desconocido"
  if c.valid?
    c.save!
    ## Beware! This can take a WHILE
    c.validate_document!
    puts (c.sender.rut)
  end

end

puts "DB seeded"






















































































