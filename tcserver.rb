require 'formula'

class Tcserver < Formula
  homepage 'http://tcserver.docs.pivotal.io/index.html'
  url 'http://public.pivotal.com.s3.amazonaws.com/releases/tcserver/4.0.0.RELEASE/tcserver-4.0.0.RELEASE-developer.tar.gz'
  sha256 '40da7cc09710de93761ff9fc0fdc7f4be20a744f52872a0aa7469ad964b63e72'
  version '4.0.0'

  def install
    rm_rf Dir['**/*.bat']
    distDir = "developer-#{version}.RELEASE"
    %w(README.txt licenses/Pivotal_EULA.txt).each do |readme|
      prefix.install ["#{distDir}/#{readme}"]
    end
    libexec.install Dir['*']
    bin.install_symlink Dir["#{libexec}/#{distDir}/tcserver"]
    tcsInstancesDir = var.join('tcserver').join('instances')
    tcsInstancesDir.mkpath
    IO.write("#{libexec}/#{distDir}/conf/tcserver.properties",
             "instances.directory=#{tcsInstancesDir}\n", mode: 'a')
  end

  def caveats; <<-EOS
    By installing, you agree to comply with the license at https://network.pivotal.io/pivotal_software_eula.
    If you disagree with these terms, please uninstall by typing "brew uninstall tcserver" in your terminal window.

    Usage:
       To create a new tc Server instance:
          > tcserver create myinstance

       To control tc Server instance:
          > tcserver start|stop|restart|status myinstance

    Documentation:
       http://tcserver.docs.pivotal.io/

    Open Source License:
       https://network.pivotal.io/open-source

    For inquiries about commercial licensing, support, training, and consulting, please contact us at:
       mailto:tcserver@pivotal.io
    EOS
  end
end
