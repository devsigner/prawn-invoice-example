require 'rubygems'
require 'prawn'

Prawn::Document.generate("invoice.pdf") do |pdf|
  
  logopath = 'logo.png'
  initial_y = pdf.cursor
  initialmove_y = 5
  address_x = 35
  invoice_header_x = 325
  lineheight_y = 12
  font_size = 9

  pdf.move_down initialmove_y

  # Add the font style and size
  pdf.font "Helvetica"
  pdf.font_size font_size

  #start with EON Media Group
  pdf.text_box "Your Business Name", :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y
  pdf.text_box "1234 Some Street Suite 1703", :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y
  pdf.text_box "Some City, ST 12345", :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y

  last_measured_y = pdf.cursor
  pdf.move_cursor_to pdf.bounds.height

  pdf.image logopath, :width => 215, :position => :right

  pdf.move_cursor_to last_measured_y

  # client address
  pdf.move_down 65
  last_measured_y = pdf.cursor

  pdf.text_box "Client Business Name", :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y
  pdf.text_box "Client Contact Name", :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y
  pdf.text_box "4321 Some Street Suite 1000", :at => [address_x,  pdf.cursor]
  pdf.move_down lineheight_y
  pdf.text_box "Some City, ST 12345", :at => [address_x,  pdf.cursor]

  pdf.move_cursor_to last_measured_y

  invoice_header_data = [ 
    ["Invoice #", "001"],
    ["Invoice Date", "December 1, 2011"],
    ["Amount Due", "$3,200.00 USD"]
  ]

  pdf.table(invoice_header_data, :position => invoice_header_x, :width => 215) do
    style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
    style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
    style(column(1), :align => :right)
    style(row(2).columns(0), :borders => [:top, :left, :bottom])
    style(row(2).columns(1), :borders => [:top, :right, :bottom])
  end

  pdf.move_down 45

  invoice_services_data = [ 
    ["Item", "Description", "Unit Cost", "Quantity", "Line Total"],
    ["Service Name", "Service Description", "320.00", "10", "$3,200.00"],
    [" ", " ", " ", " ", " "]
  ]

  pdf.table(invoice_services_data, :width => pdf.bounds.width) do
    style(row(1..-1).columns(0..-1), :padding => [4, 5, 4, 5], :borders => [:bottom], :border_color => 'dddddd')
    style(row(0), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
    style(row(0).columns(0..-1), :borders => [:top, :bottom])
    style(row(0).columns(0), :borders => [:top, :left, :bottom])
    style(row(0).columns(-1), :borders => [:top, :right, :bottom])
    style(row(-1), :border_width => 2)
    style(column(2..-1), :align => :right)
    style(columns(0), :width => 75)
    style(columns(1), :width => 275)
  end

  pdf.move_down 1

  invoice_services_totals_data = [ 
    ["Total", "$3,200.00"],
    ["Amount Paid", "-0.00"],
    ["Amount Due", "$3,200.00 USD"]
  ]

  pdf.table(invoice_services_totals_data, :position => invoice_header_x, :width => 215) do
    style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
    style(row(0), :font_style => :bold)
    style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
    style(column(1), :align => :right)
    style(row(2).columns(0), :borders => [:top, :left, :bottom])
    style(row(2).columns(1), :borders => [:top, :right, :bottom])
  end

  pdf.move_down 25

  invoice_terms_data = [ 
    ["Terms"],
    ["Payable upon receipt"]
  ]

  pdf.table(invoice_terms_data, :width => 275) do
    style(row(0..-1).columns(0..-1), :padding => [1, 0, 1, 0], :borders => [])
    style(row(0).columns(0), :font_style => :bold)
  end

  pdf.move_down 15

  invoice_notes_data = [ 
    ["Notes"],
    ["Thank you for doing business with Your Business Name"]
  ]

  pdf.table(invoice_notes_data, :width => 275) do
    style(row(0..-1).columns(0..-1), :padding => [1, 0, 1, 0], :borders => [])
    style(row(0).columns(0), :font_style => :bold)
  end

end