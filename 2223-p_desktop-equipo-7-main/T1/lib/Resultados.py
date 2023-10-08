from logging import exception
from pkgutil import get_data
from shutil import which
import threading
import locale
import gettext

from time import sleep
from typing import Sequence
import gi



from controlador import displayResults, getData  

from card import Card
from cheathelper import CheatEntry, get_cheatsheet

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib

_ = gettext.gettext
N_ = gettext.ngettext

class Resultados(Gtk.VBox):
    def __init__(self, comando : str, win : Gtk.Window, time : int):
        super().__init__()
        self.win = win
        self.comando = comando
        self.time = time
        self.spinner = Gtk.Spinner()

        self.spinner.get_style_context().add_class("spinner")
        self.threadBusqueda = None

        
        

        #Declaramos los layoutWidgets que vamos a utilizar.
        box = Gtk.Box(spacing=6) #Va a contener la barra de búsqueda y los botones Buscar y Casa.
        centerBox = Gtk.Box()#Se encargará de centrar horizontalmente box.
        
        abajo = Gtk.Box() # Aquí se renderizarán los resultados.
        arriba = Gtk.Box() # Aquí se renderizará el Banner de la aplicación.
        
        abajoIzq = Gtk.VBox() # Primeras 4 cards
        abajoDrch = Gtk.VBox() # Siguientes 4 cards

        #Incluimos una hoja CSS
        screen = self.get_screen ()
        css_provider =  Gtk.CssProvider()
        path = "./../styles/mystylesheet.css"
        css_provider.load_from_path(path)
        Gtk.StyleContext.add_provider_for_screen(screen, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER)
        
            
        


        #Titulo de la página
        titulo = Gtk.Label(label = _("Escribe un comando Linux"))
        titulo.get_style_context().add_class("title")
        arriba.set_center_widget(titulo)


        #Buscador con botón de búsqueda y casa.
        self.entry = Gtk.SearchEntry()
        self.entry.set_placeholder_text(_("Comando"))
        self.button = Gtk.Button(label="🧭")
        self.button.get_style_context().add_class(_("buscar"))
        buttonCasa = Gtk.Button(label= "🏠")
        buttonCasa.get_style_context().add_class(_("buscar"))
        buttonCasa.connect("clicked", self.irCasa) #Añadimos funcion irCasa.
        self.button.connect("clicked", self.generarThread) #Añadimos funcion buscar.
        box.pack_start(self.entry, True, True, 0)
        box.pack_start(self.button, False, False, 0)
        box.pack_start(buttonCasa, False, False, 0)
        box.pack_start(self.spinner, False, False, 0)
        separator = Gtk.Separator(orientation = Gtk.Orientation.HORIZONTAL)
        separator.get_style_context().add_class("separator")
        separatorV = Gtk.Separator(orientation = Gtk.Orientation.VERTICAL)
        separatorV.get_style_context().add_class("separator")
        abajo.set_center_widget(separatorV)
        leftBtn = Gtk.Button(label = "⋘") #Botón de retroceso en la paginación.
        leftBtn.connect("clicked", self.previousPage) #Añadimos función previousPage.
        rightBtn = Gtk.Button(label = "⋙") #Botón de avance en la paginación.
        rightBtn.connect("clicked", self.nextPage) #Añadimos función nextPage.
        leftBtn.get_style_context().add_class("arrow")
        rightBtn.get_style_context().add_class("arrow")


        #Creación de las cartas incluidas en la página.
        card1 = Card("Comando")
        card2 = Card("Comando")
        card3 = Card("Comando")
        card4 = Card("Comando")
        card5 = Card("Comando")
        card6 = Card("Comando")
        card7 = Card("Comando")
        card8 = Card("Comando")

        #Localizamos las cartas en su correspondiente lugar.
        abajoIzq.pack_start(card1, True,True,50)
        abajoIzq.pack_start(card2, True,True,0)
        abajoIzq.pack_start( Gtk.Box(), False, False, 25)
        abajoIzq.pack_start(card3, True,True, 0)
        abajoIzq.pack_start(card4, True,True,50)
        abajo.pack_start(abajoIzq,True,True,50)
        abajoDrch.pack_start(card5, True,True,50)
        abajoDrch.pack_start(card6, True,True,0)
        abajoDrch.pack_start( Gtk.Box(), False, False, 25)
        abajoDrch.pack_start(card7, True,True, 0)
        abajoDrch.pack_start(card8, True,True,50)
        abajoDrch.pack_start(rightBtn, False, False, 10)
        abajoIzq.pack_start(leftBtn, False, False, 10)
        abajo.pack_end(abajoDrch,True,True,50)
        
        
        #Alineamos los widgets de manera oportuna.
        centerBox.pack_start(box, True, True, 50)
        self.pack_start(arriba,False,False,15)
        self.pack_start(centerBox,False,False,30)
        self.pack_start(separator,False, False, 0)
        self.pack_start(abajo, True, True, 0)

        
        self.switcher = { #Diccionario de las cartas de la página.
             1: card1,
             2: card2,
             3: card3,
             4: card4,
             5: card5,
             6: card6,
             7: card7,
             8: card8   
            }
        self.lista = get_cheatsheet(comando)
        
        
        displayResults(self.switcher, self.lista, time)
        

        

    def buscar(self): # Actualizamos el contenido de la ventada con los resultados.

        if self.entry.get_text() != "":
            try:
                self.lista = get_cheatsheet(self.entry.get_text())
                if len(self.lista) == 0:
                    GLib.idle_add( self.win.Pagination, self, Gtk.Box(), False, True, False)
                else:
                    GLib.idle_add(self.win.Pagination,self, Resultados(self.entry.get_text(), self.win, 0), False, False, False) #Se añade el nuevo contenido
                
            except:
                GLib.idle_add(self.win.Pagination,self, Gtk.Box(), False, False, True)
        else:
            GLib.idle_add(self.win.Pagination, self, Gtk.Box(), False, True, False)
        

    def nextPage(self, widget): # Avanzamos por los resultados actualizando el contenido de la página.
        if(len(self.lista) > 8):
            try:
                
                if len(self.lista) == 0:
                    self.win.Pagination(self, Gtk.Box(), False, True, False)
                else:
                    
                    displayResults(self.switcher, self.lista, self.time +1)
                    self.time = self.time +1
            except:
                print("No more info")
                

    def previousPage(self, widget): 
        if self.time != 0:
            try:
                
                if len(self.lista) == 0:
                    self.win.Pagination(self, Gtk.Box(), False, True, False)
                else:
                    displayResults(self.switcher, self.lista, self.time -1)
                    self.time = self.time -1
            except:
                self.win.Pagination(self, Gtk.Box(), False, False, True)

    def irCasa(self, widget): #Reiniciamos el contenido de la página.
        self.win.Pagination(self,Gtk.Box(), True, False, False)

    def generarThread(self, widget):#Crea un Thread e inicializa el spinner.
        if self.threadBusqueda is None:
            self.spinner.start()
            new_thread = threading.Thread(target= self.buscar, daemon= True)
            self.threadBusqueda = new_thread
            self.threadBusqueda.start()

    

            
            



