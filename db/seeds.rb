AdminUser.create(username: 'admin', password: 'admin123') # if Rails.env.development?

Setting.set('allow_jump_queue', 'true')
Setting.set('service_time_per_customer', '3')
Setting.set('max_capacity', '10')
