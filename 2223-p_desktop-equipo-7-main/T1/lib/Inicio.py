#!/usr/bin/env python3

from time import sleep
from typing import Sequence
from warnings import catch_warnings
from xmlrpc.client import Boolean

import locale
import gettext
import gi
import threading
from pathlib import Path

from Resultados import Resultados
from Not_Found import NotFound
from Error_Serv import ErrorServ
from controlador import getData


gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk, GLib


_ = gettext.gettext
N_ = gettext.ngettext

class MyWindow(Gtk.Window):
    def __init__(self):
        super().__init__(title="Cheat.sh")
        self.set_default_size(1920,980)
        self.set_resizable(False)
        
        
        self.comprobante = False
        
        
        

        self.spinner = Gtk.Spinner()

        self.spinner.get_style_context().add_class("spinner")
        self.threadBusqueda = None


        
        

        #Declaramos los layoutWidgets que vamos a utilizar.
        self.box = Gtk.Box(spacing=6)
        centerBox = Gtk.Box()
        self.centerVBox = Gtk.VBox()
        abajo = Gtk.Box()
        arriba = Gtk.Box()
        borde_sup = Gtk.Box()
        

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

        #Imagen de la página
        logo = Gtk.Image()
        logo.set_from_file('./../images/logo_negro.jpg')
        abajo.set_center_widget(logo)


        #Buscador con botón de búsqueda
        self.entry = Gtk.SearchEntry()
        

        
        self.entry.set_placeholder_text(_("Comando"))
        self.button = Gtk.Button(label="🧭")
        self.button.get_style_context().add_class(_("buscar"))
        self.entry.set_activates_default(True)
        
        self.button.connect("clicked", self.generarThread)
        self.box.pack_start(self.entry, True, True, 0)
        self.box.pack_start(self.button, False, False, 0)
        self.box.pack_start(self.spinner, False, False, 0)
        #separator = Gtk.Separator(orientation = Gtk.Orientation.HORIZONTAL)
        #separator.get_style_context().add_class("separator")
        
        
        #Alineamos los widgets de manera oportuna.
        centerBox.pack_start(self.box, True, True, 50)
        self.centerVBox.pack_start(borde_sup, False, False, 75)
        self.centerVBox.pack_start(arriba,False,False,50)
        self.centerVBox.pack_start(centerBox,False,False,0)
        #centerVBox.pack_start(separator,False, False, 15)
        self.centerVBox.pack_start(abajo, True, True, 10)
        

        #Añadimos los widgets a la ventana.
        self.add(self.centerVBox)

        


       
    
                
        
        
    def generarThread(self, widget):
        if self.threadBusqueda is None:
            self.spinner.start()
            new_thread = threading.Thread(target= self.buscar, daemon= True)
            
            
            self.threadBusqueda = new_thread
            
            
            self.threadBusqueda.start()
            
            
            
        
   
        


    



    def buscar(self):
         #Se elimina el contenido de la ventana.
        
        
        if self.entry.get_text() != "":
            try:
                
                lista = getData(self.entry.get_text())
                self.remove(self.centerVBox)
                if len(lista) == 0:
                    self.add(NotFound(self))
                else:
                    self.add(Resultados(self.entry.get_text(),self, 0)) #Se añade el nuevo contenido

                
                GLib.idle_add(self.show_all)
            except:
                
                self.remove(self.centerVBox)
                self.add(ErrorServ(self))
                GLib.idle_add(self.show_all)
        else:
            self.remove(self.centerVBox)
            self.add(NotFound(self))
            GLib.idle_add(self.show_all)
        
        
        
        
    
    


    
            
            



            
        
    
        
    
    

    
    #El metodo Paginación nos permite actualizar la ventana desde otra.

    def Pagination(self, Origen, To, resetear : Boolean, not_found : Boolean, error_serv : Boolean):
        self.remove(Origen)
        #Si resetear == True -> entonces queremos reiniciar la pagina inicial.
        if(resetear):
            self.__init__()
        else: #Sino queremos renderizar otra.
            if(not_found):
                self.add(NotFound(self))
            elif (error_serv):
                self.add(ErrorServ(self))
            else:
                self.add(To)

        self.show_all()
        del(Origen)

        
        
        

        
        
#INTERNACIONALIZACION
locale.setlocale(locale.LC_ALL, '')
LOCALE_DIR = Path(__file__).parent / "locale"
locale.bindtextdomain('HelloWorld', LOCALE_DIR)
gettext.bindtextdomain('HelloWorld', LOCALE_DIR)
gettext.textdomain('HelloWorld')
win = MyWindow()


win.get_style_context().add_class("window")
win.connect("destroy", Gtk.main_quit)
win.show_all()


Gtk.main()


