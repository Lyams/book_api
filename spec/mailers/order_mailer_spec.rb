# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  let(:product) { create :product }
  let(:order) { create :order, products: [product], user: product.user }

  describe 'send_confirmation' do
    # let(:mail) { OrderMailer.send_confirmation }

    it 'renders the headers' do
      mail = described_class.send_confirmation(order)
      expect(mail.subject).to eq('Order Confirmation')
      expect(mail.to).to eq([order.user.email])
      expect(mail.from).to eq(['no-reply@example.com'])
      expect(mail.body.encoded).to match "You ordered #{order.products.count}"
    end
  end
end
