from cProfile import label
from tokenize import String
from xmlrpc.client import Boolean

import gi
import locale
import gettext
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

_ = gettext.gettext
N_ = gettext.ngettext

class Card(Gtk.Box):

    

    def __init__(self, command:str):
        super().__init__()
        
        self.styleChooser = False
        
        #Incluimos una hoja CSS
        screen = self.get_screen ()
        css_provider =  Gtk.CssProvider()

        path = "./../styles/mystylesheet.css"
        css_provider.load_from_path(path)
        Gtk.StyleContext.add_provider_for_screen(screen, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER)

        

        vertical = Gtk.VBox()
        self.result = Gtk.Label(label = " ")
        


        self.label = Gtk.Label(label = command)
        vertical.pack_start(self.label, False, False, 5)
        separator = Gtk.Separator(orientation = Gtk.Orientation.HORIZONTAL)
        separator.get_style_context().add_class("separator_card")
        self.label.get_style_context().add_class("label_hidden")
        self.get_style_context().add_class("card_hidden")

        
        vertical.pack_start(separator,False, False, 5)

        vertical.pack_start(self.result, True, True, 0)
        self.pack_start(vertical, True, True,0)
    
    def setLabel(self, lbl :str):
        self.label.set_label(lbl)
    def setInfo(self, info : str):
        self.result.set_label(info)

    def hide(self, destiny : Boolean): #Cambia el estilo de los widgets de la carta para que desaparezca.
        if self.styleChooser and not destiny:
            self.label.get_style_context().add_class("label_hidden")
            self.get_style_context().add_class("card_hidden")
            self.result.get_style_context().add_class("label_hidden")
            self.styleChooser = False
        elif not self.styleChooser and destiny:
            self.label.get_style_context().remove_class("label_hidden")
            self.get_style_context().remove_class("card_hidden")
            self.result.get_style_context().remove_class("label_hidden")
            self.label.get_style_context().add_class("label")
            self.get_style_context().add_class("card")
            self.result.get_style_context().add_class("label")
            self.styleChooser = True


    
        
    

        
        





    
