class AttachXmlJob < ApplicationJob
  queue_as :default

  def perform nfe_invoice
    Nfeio::Invoices::InvoiceDownloadXmlService.new(nfe_invoice)
  end
  
end
