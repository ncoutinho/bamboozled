xml.Projects do
  @build_info.each do |build|
    xml.Project(
      :name => build.name,
      :activity => build.activity,
      :lastBuildStatus => build.status,
      :lastBuildTime => build.last_build_time,
      :webUrl => summary_url(build.key)
    )
  end
end
