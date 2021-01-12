shares = Share.all
shares.each do |share|
    if share.industry.nil?
        industry = Industry.where(name: share.industry_id)[0].id
        share.update!(industry_id: industry)
    end
end