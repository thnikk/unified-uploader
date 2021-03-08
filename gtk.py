import gi
# Use external commands
import subprocess

import os

import sys
import glob
import serial

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk


class FlowBoxWindow(Gtk.Window):

    def serial_ports(self):
        if sys.platform.startswith('win'):
            ports = ['COM%s' % (i + 1) for i in range(256)]
        elif sys.platform.startswith('linux') or sys.platform.startswith('cygwin'):
            # this excludes your current terminal "/dev/tty"
            ports = glob.glob('/dev/ttyACM*')
        elif sys.platform.startswith('darwin'):
            ports = glob.glob('/dev/tty.*')
        else:
            raise EnvironmentError('Unsupported platform')

        return ports

    def __init__(self):
        Gtk.Window.__init__(self, title="Unified Uploader")
        self.set_border_width(10)
        self.set_default_size(300, 250)

        # Set title and subtitle in header bar
        # header = Gtk.HeaderBar(title="Unified Uploader")
        # header.set_subtitle("Click a button to select a model")
        # header.props.show_close_button = True

        # self.set_titlebar(header)

        scrolled = Gtk.ScrolledWindow()
        scrolled.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC)

        flowbox = Gtk.FlowBox()
        flowbox.set_valign(Gtk.Align.START)
        flowbox.set_max_children_per_line(3)
        flowbox.set_selection_mode(Gtk.SelectionMode.NONE)

        # # Create label
        # name = Gtk.Label(label="Select a port:")
        # flowbox.add(name)

        # # Create port selector
        # port_select = Gtk.ComboBoxText()
        # port_select.set_entry_text_column(0)
        # port_select.connect("changed", self.on_port_select_changed)
        # for ports in self.serial_ports():
            # port_select.append_text(ports)
        # port_select.set_active(0)
        # flowbox.add(port_select)

        self.create_flowbox(flowbox)

        scrolled.add(flowbox)


        self.add(scrolled)
        self.show_all()

    # def on_port_select_changed(self, combo):
        # text = combo.get_active_text()
        # if text is not None:
            # # Set the port here
            # global PORT
            # PORT = text
            # print("Selected port:%s" % text)


    def on_click(self,button,model):
        # If 1 or more serial ports exist
        if self.serial_ports():
            # Upload code to the selected port.
            port=self.serial_ports()[0]
            # print("Upload code for " + model + " to " + port)
            command="sh -c upload.sh " + model + " " + port
            print(command)
            process = subprocess.run(['./upload.sh', model, port], cwd=os.path.dirname(os.path.realpath(__file__)))
            process

    def create_flowbox(self, flowbox):

        models = [
            "2k",
            "2kW",
            "4k",
            "4kW",
            "2kt",
            "4kt",
        ]

        for model in models:
            button = Gtk.Button(label=model)
            button.connect("clicked", self.on_click, model)
            button.set_size_request(width=-1, height=130)
            flowbox.add(button)


win = FlowBoxWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()
