from time import sleep
from typing import Sequence
from card import Card
from cheathelper import CheatEntry, get_cheatsheet



def getData(comando : str) -> Sequence[CheatEntry]:
        return  get_cheatsheet(comando)



def displayResults(cartas : dict, lista, time : int):

    #cartas es un diccionario x = {} que contiene 8 objetos de tipo card (1..8).
    #time es el número de página que queremos actualizar:
    #   Página 0 -> 8 primeros resultados. (0..7) 
    #   Página 1 -> 8 siguientes. (8..15)
    
    
    x =0
    for i in range(time*8, len(lista)):
        
        
        if(x<8): # Si x == 8, el contenido es renderizable en esta página, sino
                 #necesitaríamos otra
            
            modified : Card = cartas.get(x+1)
            modified.hide(True)
            modified.setLabel(lista[i].commands)
            modified.setInfo(lista[i].description)
            
            
        x = x+1

    for i in range(len(lista), (time+1)*8): 
        #Cambiamos el style de las tarjetas vacías para que desaparezcan.
        card : Card = cartas.get(i-(8*time)+1)
        card.hide(False)
