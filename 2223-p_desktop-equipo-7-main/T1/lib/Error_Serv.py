import threading
from time import sleep
from typing import Sequence
import gi
import locale
import gettext

from Resultados import Resultados
from Not_Found import NotFound
from cheathelper import CheatEntry, get_cheatsheet

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib

_ = gettext.gettext
N_ = gettext.ngettext

class ErrorServ(Gtk.VBox):
    def __init__(self, win : Gtk.Window):
        super().__init__()
        self.win = win
        self.spinner = Gtk.Spinner()

        self.spinner.get_style_context().add_class("spinner")
        self.threadBusqueda = None
        
        

        #Declaramos los layoutWidgets que vamos a utilizar.
        box = Gtk.Box(spacing=6)
        centerBox = Gtk.Box()
        centerVBox = Gtk.VBox()
        abajo = Gtk.Box()
        arriba = Gtk.Box()
        

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

        #Imagen de la página y mensaje de error
        image = Gtk.Image()
        image.set_from_file('./../images/sad.png')

        error = Gtk.Label(label = _("ERROR DE SERVIDOR"))
        abajo.get_style_context().add_class("error_text")
        vertical = Gtk.VBox()
        vertical.pack_start(error,False,False,0)
        vertical.pack_start(image,False,False,50)
        abajo.set_center_widget(vertical)
        


        #Buscador con botón de búsqueda
        self.entry = Gtk.SearchEntry()
        self.entry.set_placeholder_text(_("Comando"))
        self.button = Gtk.Button(label="🧭")
        self.button.get_style_context().add_class("buscar")
        self.button.connect("clicked", self.generarThread)
        buttonCasa = Gtk.Button(label= "🏠")
        buttonCasa.get_style_context().add_class("buscar")
        buttonCasa.connect("clicked", self.irCasa)
        box.pack_start(self.entry, True, True, 0)
        box.pack_start(self.button, False, False, 0)
        box.pack_start(buttonCasa, False, False, 0)
        box.pack_start(self.spinner, False, False, 0)
        separator = Gtk.Separator(orientation = Gtk.Orientation.HORIZONTAL)
        separator.get_style_context().add_class("separator")
        
        
        #Alineamos los widgets de manera oportuna.
        centerBox.pack_start(box, True, True, 50)
        centerVBox.pack_start(arriba,False,False,50)
        centerVBox.pack_start(centerBox,False,False,0)
        centerVBox.pack_start(separator,False, False, 30)
        centerVBox.pack_start(abajo, True, True, 100)

        #Añadimos los widgets a la ventana.
        self.add(centerVBox)

    def buscar(self): # Actualizamos el contenido de la ventada con los resultados.
        if self.entry.get_text() is not "":
            try:
                lista = get_cheatsheet(self.entry.get_text())
                if len(lista) == 0:
                    GLib.idle_add( self.win.Pagination, self, Gtk.Box(), False, True, False)
                else:
                    GLib.idle_add(self.win.Pagination,self, Resultados(self.entry.get_text(), self.win, 0), False, False, False) #Se añade el nuevo contenido
                
            except:
                GLib.idle_add(self.win.Pagination,self, Gtk.Box(), False, False, True)
        else:
            GLib.idle_add(self.win.Pagination, self, Gtk.Box(), False, True, False)

    def generarThread(self, widget):#Crea un Thread e inicializa el spinner.
        if self.threadBusqueda is None:
            self.spinner.start()
            new_thread = threading.Thread(target= self.buscar, daemon= True)
            self.threadBusqueda = new_thread
            self.threadBusqueda.start()

    def irCasa(self, widget): #Reiniciamos el contenido de la página.
        self.win.Pagination(self,Gtk.Box(), True, False, False)

    def getData(self, comando : str) -> Sequence[CheatEntry]:
        
        sleep(2)

        return  get_cheatsheet(comando)
