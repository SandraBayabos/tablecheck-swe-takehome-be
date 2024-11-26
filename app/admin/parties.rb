ActiveAdmin.register Party do
  menu priority: 2
  permit_params :name, :size, :status

  controller do
    def new
      @party = Party.new(status: 'in_queue')
    end
  end

  index do
    div class: 'spacer-y-2 p-2' do
      div(class: 'text-sm') { "In-Queue: #{Party.in_queue.sum(:size)}" }
      div(class: 'text-sm') { "Pending Check-In: #{Party.pending_check_in.sum(:size)}" }
      div(class: 'text-sm') { "Seated: #{Party.seated.sum(:size)}" }
      div(class: 'text-sm') { "Capacity: #{Party.remaining_capacity}" }
    end
    selectable_column
    id_column
    column :name
    column :size
    column :status do |party|
      Party.statuses[party.status]
    end
    column :created_at
    column :updated_at
    actions defaults: true do |party|
      item 'Check In', check_in_admin_party_path(party), method: :put if party.pending_check_in?
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :size
      f.input :status, as: :select, collection: Party.statuses.map { |k, v| [v, k] }
    end
    f.actions
  end

  action_item :seed_random_parties, only: :index do
    link_to 'Seed Random Parties', seed_random_parties_admin_parties_path, method: :post,
                                                                           class: 'action-item-button',
                                                                           data: { confirm: 'This will seed 3 parties to full capacity. Proceed?' }
  end

  action_item :toggle_allow_jump_queue, only: :index do
    link_to Party.allow_jump_queue? ? 'Disable Jump Queue' : 'Allow Jump Queue',
            toggle_allow_jump_queue_admin_parties_path, method: :post,
                                                        class: 'action-item-button',
                                                        data: { confirm: 'This will toggle the jump queue feature. Proceed?' }
  end

  collection_action :seed_random_parties, method: :post do
    total_capacity = 10
    party_count = 3
    remaining_capacity = total_capacity
    parties = []

    party_count.times do |i|
      size = i == party_count - 1 ? remaining_capacity : rand(1..remaining_capacity - (party_count - i - 1))
      party = Party.new(name: Faker::Name.name, size: size)
      if party.save
        parties << party
        remaining_capacity -= size
      else
        redirect_to admin_parties_path, alert: "Failed to create parties: #{party.errors.full_messages.join(', ')}"
        return
      end
    end

    redirect_to admin_parties_path,
                notice: "#{parties.map(&:name).join(', ')} are now in queue with total size #{total_capacity - remaining_capacity}!"
  end

  collection_action :toggle_allow_jump_queue, method: :post do
    new_value = Setting.toggle('allow_jump_queue')
    redirect_to admin_parties_path, notice: "Jump Queue is now #{new_value ? 'enabled' : 'disabled'}!"
  end

  member_action :check_in, method: :put do
    party = Party.find(params[:id])
    party.update!(status: 'seated')
    redirect_to admin_parties_path, notice: "#{party.name} is now seated!"
  end
end
