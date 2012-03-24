# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */
require 'rubygems'
require 'bundler/setup'

require 'java'
require 'netty-3.3.1.Final.jar'

java_import java.net.InetSocketAddress
java_import java.util.concurrent.Executors
java_import org.jboss.netty.channel.socket.nio.NioServerSocketChannelFactory

java_import org.jboss.netty.channel.ChannelFactory
java_import org.jboss.netty.channel.ChannelPipelineFactory
java_import org.jboss.netty.channel.Channels
java_import org.jboss.netty.handler.codec.http.HttpContentCompressor
java_import org.jboss.netty.handler.codec.http.HttpRequestDecoder
java_import org.jboss.netty.handler.codec.http.HttpResponseEncoder

java_import org.jboss.netty.util.CharsetUtil
java_import org.jboss.netty.buffer.ChannelBuffers
java_import org.jboss.netty.channel.ChannelFutureListener
java_import org.jboss.netty.handler.codec.http.HttpVersion
java_import org.jboss.netty.handler.codec.http.HttpHeaders
java_import org.jboss.netty.handler.codec.http.HttpRequest
java_import org.jboss.netty.handler.codec.http.HttpResponse
java_import org.jboss.netty.handler.codec.http.HttpResponseStatus
java_import org.jboss.netty.channel.SimpleChannelUpstreamHandler
java_import org.jboss.netty.handler.codec.http.DefaultHttpResponse

class HttpServerPipeline
  include ChannelPipelineFactory

  def getPipeline
    pipeline = Channels.pipeline()
    pipeline.addLast('decoder', HttpRequestDecoder.new)
    pipeline.addLast('encoder', HttpResponseEncoder.new)
    pipeline.addLast('deflater', HttpContentCompressor.new)
    pipeline.addLast('handler', HttpRequestHandler.new)
    pipeline
  end
end

class HttpRequestHandler < SimpleChannelUpstreamHandler
  public
  def messageReceived(context, event)
    request = event.getMessage
    keep_alive = HttpHeaders.isKeepAlive(request)

    response = DefaultHttpResponse.new(HttpVersion::HTTP_1_1, HttpResponseStatus::OK)
    response.setContent(ChannelBuffers::copiedBuffer('tetest'.to_java_bytes))
    response.setHeader(HttpHeaders::Names::CONTENT_TYPE, 'text/plain; charset=UTF-8')
    response.setHeader(HttpHeaders::Names::CONTENT_LENGTH, response.getContent.readableBytes) if keep_alive

    future = event.getChannel.write(response)

    future.addListener(ChannelFutureListener.CLOSE) unless keep_alive
  end
end

factory = NioServerSocketChannelFactory.new(
  Executors.newCachedThreadPool,
  Executors.newCachedThreadPool)
bootstrap = org.jboss.netty.bootstrap.ServerBootstrap.new(factory)
bootstrap.setPipelineFactory(HttpServerPipeline.new)
bootstrap.setOption("child.tcpNoDelay", true)
bootstrap.setOption("child.keepAlive", true)
bootstrap.bind(InetSocketAddress.new(8080))
