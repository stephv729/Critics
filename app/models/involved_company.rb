class InvolvedCompany < ApplicationRecord
  belongs_to :company
  belongs_to :game

  after_update :clean

  private

  def clean
    # Hace referencia que no tiene ni developer ni publisher y lo elimina si es el caso.
    InvolvedCompany.delete(self) unless self.developer || self.publisher
  end
end
