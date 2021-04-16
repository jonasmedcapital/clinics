class AttachPdfJob < ApplicationJob
  queue_as :default

  def perform nfe_invoice
    Nfeio::Invoices::InvoiceDownloadPdfService.new(nfe_invoice)
  end
  
end
