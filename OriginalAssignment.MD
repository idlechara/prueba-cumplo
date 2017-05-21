# __TAREA PARA JUNIOR DEV__

Parte del negocio de Cumplo se basa en el modelo de factoring. En este contexto, se hace necesario manejar a tiempo información respecto al proceso de cesión de facturas a la empresa. A fin de facilitar esta labor, te pedimos construir una aplicación en Ruby on Rails que capture esta información de cesión y la almacene en su modelo de datos, según el criterio que estimes conveniente. 

Las facturas poseen bastante información que permite la comprobación de cesión, el rut del pagador de la factura, el folio, y el rut de la empresa a la cual están cedidas las facturas, para este caso te adjuntamos un dataset de información, donde todas poseen un rut en común (que es el de la empresa a la que están cedidas, que es Cumplo, rut: 76.177.621-5)

__Datos:__

|Folios |Monto |Rut Pagador|
|-|-|-|
|027|$2122960|76.273.545-8|
|026|$702100|76.273.545-8|
|237|$1785000|76.273.545-8|
|234|$2677500|76.273.545-8|
|233|$2677500|76.273.545-8|
|232|$3808000|76.273.545-8|
|231|$809200|76.273.545-8|
|230|$3808000|76.273.545-8|
|178|$1695750|79.517.200-9|
|177|$641265|79.517.200-9|
|487|$15621846|79.517.200-9|
|296|$54335404|79.517.200-9|
|59|$2376682|79.517.200-9|
|494|$15114695|79.517.200-9|
|561612|$249900|79.517.200-9|
|563501|$67045|79.517.200-9|
|563639|$392224|79.517.200-9|
|563640|$83538|79.517.200-9|
|563641|$501228|79.517.200-9|
|563791|$521458|79.517.200-9|
|563792|$76160|79.517.200-9|
|564049|$334152|79.517.200-9|
|564050|$652339|79.517.200-9|
|564051|$475500|79.517.200-9|
|564052|$53663|79.517.200-9|
|564613|$3042628|79.517.200-9|
|564640|$134732|79.517.200-9|
|564641|$631165|79.517.200-9|
|564642|$646765|79.517.200-9|
|565062|$815424|79.517.200-9|
|565066|$507892|79.517.200-9|
|565540|$194506|79.517.200-9|
|565547|$43435|79.517.200-9|
|565827|$283118|79.517.200-9|
|566309|$285600|79.517.200-9|
|566310|$99960|79.517.200-9|
|566317|$139746|79.517.200-9|
|566360|$1107236|79.517.200-9|
|567784|$64260|79.517.200-9|
|567785|$4006|79.517.200-9|
|567786|$57122|79.517.200-9|
|568131|$15470|79.517.200-9|
|568499|$514080|79.517.200-9|
|568500|$5355|79.517.200-9|
|62|$6179500|79.517.200-9|

__Debe cumplir las siguientes condiciones:__

Debes investigar si puedes utilizar alguna de las herramientas que entrega el Servicio de Impuestos internos (en este link: http://www.sii.cl/factura_electronica/factura_mercado/instructivo.htm)
En el caso de que alguno de estos WebService no te resulte atractivo, debes elegir la mejor solución para el problema.
El usuario debe poder ingresar a una aplicación web y ver un listado con información de las últimas cesiones de factura.
El usuario debe poder buscar y filtrar información de las cesiones según fecha, estado de cesión y folio de facturas.

__Requerimientos tecnológicos:__
* Rails 5.1.0 o superior
* Ruby 2.3.1
* MySQL 5.7.16 o superior