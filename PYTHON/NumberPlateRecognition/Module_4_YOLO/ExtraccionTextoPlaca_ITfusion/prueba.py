import re

texto = "CKG:716"

# Definir la expresión regular

patron = r"([a-zA-Z]{3}).(\d{3})"
resultado = re.search(patron, texto)
if resultado:
   print("Número de placa encontrado:", resultado.group(1)+'-'+resultado.group(2))
else:
   print('Placa no encontrada')
