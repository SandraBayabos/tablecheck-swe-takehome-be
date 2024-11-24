ActiveAdmin.register Party do
  menu priority: 1
  permit_params :name, :size, :status

  controller do
    def new
      @party = Party.new(status: 'in_queue')
    end
  end

  index do
    div class: "spacer-y-2 p-2" do
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

  member_action :check_in, method: :put do
    party = Party.find(params[:id])
    party.update!(status: 'seated')
    redirect_to admin_parties_path, notice: "#{party.name} is now seated!"
  end
end
