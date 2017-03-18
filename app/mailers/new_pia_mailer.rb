class NewPiaMailer < ApplicationMailer
  def receive(email)
#    myEmail = Hash.from_xml(data)["form"]["Email"]
    data = email.body.to_s.tr('&', '')
#    myEmail = /Email: (.*)\n/.match(data)[1]
    myEmail = data.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
    if(myEmail.length > 1)
      myEmail = myEmail[1]
    end
    newPia = domain(999, delimiter='-')
    pwdSelect = random_seed % passwords.length

    retVal = ""
    cnt = 0
    while (retVal.delete("\s") == "" || cnt < 5) do
      cmd = "/home/user/docker/oyd-pia/build.sh"
      cmd += " --load-image=oydeu/oyd-pia"
      cmd += " --name=" + newPia
      cmd += " --vault-personal"
      cmd += " --password=" + password_hashes[pwdSelect]
      retVal =  `#{cmd}`
      cnt = cnt +1
    end
    url = "https://#{newPia}.datentresor.org"
    password = passwords[pwdSelect]
    PiaMailer.pia_created(myEmail, url, password).deliver
    PiaMailer.pia_created("backup@ownyourdata.eu", url, "").deliver
  end

    # from https://github.com/usmanbashir/haikunator/blob/master/lib/haikunator.rb
    def domain(token_range, delimiter)
        sections = [
            adjectives[random_seed % adjectives.length],
            writers[random_seed % writers.length],
            token(token_range)
        ]
        sections.compact.join(delimiter)
    end

    def random_seed
        SecureRandom.random_number(4096)
    end

    def token(range)
        SecureRandom.random_number(range) if range > 0
    end

    def password_hashes
      [ '\\\\\$2a\\\\\$10\\\\\$/sWOSxUQEu8h3VBVKVALmebM4J0zpD25LHsSUoPuFQTVb0J7isTSi',
        '\\\\\$2a\\\\\$10\\\\\$SxPv58VcE5G6HP1UJn8r2.edhqR3cvlSNXNdIJTX.x4932aFINIjC',
        '\\\\\$2a\\\\\$10\\\\\$DopJDxG7vcfCRWv4MUk3huR5tardRm3WTdkf/160VebJg6lsNm8V2' ]
    end

    def passwords
      %w( ChangeMe? TooWeak. NoSecret! )
    end

    def adjectives
      %w(
        silent quiet cool patient lingering lazy
        bold shy wandering wild young holy silly
        solitary aged proud funny bragging
        restless divine lively
      )
    end

    def writers
        %w(abbt abel adams affry aisse alembert baader bahrdt basedow bayle beccaria
          becker beckmann behn campe condorcet chambers cobenzl collins condillac dahnert
          damilaville danzer darjes defoe ebeling ehlers ehrmann eichhoff engel feder
          fellenberg ferguson forster galiani galilei farbe gedike halem hanke
          herder herz holst hume ickstatt iselin jacobi jefferson johlson kant keller
          klein knigge kraus lambert leibniz locke lindner mably meslier meyer milton
          moritz noodt overbeck pagano paine pnin querini raspe reid sarasin schiede
          schultz suhl swieten teller thieme tobler unzer volland voltaire waser wessely
          wilkes wolf zaupser ziegler zwack
        )
    end
end
