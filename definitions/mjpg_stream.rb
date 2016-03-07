define :mjpg_stream, :name => nil, :variables => {} do
  Chef::Log.info("Making mjpg_stream #{params[:name]}")

  input_options = ["-d #{params[:device]}"]
  input_options << "-y" if params[:yuv]
  input_options << "-f #{params[:fps]}" if params[:fps]
  input_options << "-r #{params[:size]}" if params[:size]

  output_options = ["-p #{params[:port]}"]
  output_options << "-w #{params[:www]}" if params[:www]

  include_recipe "runit"

  runit_service params[:name] do
    cookbook 'mjpg-streamer'
    template_name 'mjpg-stream'

    owner params[:owner]
    group params[:group]

    run_restart true

    options(
      :input_options => input_options.join(' '),
      :output_options => output_options.join(' ')
    )
  end
end
