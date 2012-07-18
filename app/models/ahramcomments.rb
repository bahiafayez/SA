#encoding: utf-8

require "net/http"
require "uri"
require "open-uri"
require "rails"
require "pp"



class Ahramcomments < ActiveRecord::Base
#################################### Youm7 comments #########################################

def initialize(aid)
  @aid=aid
end


def html_getter(url)
	

	tries=0
    begin
     
      uri = URI.parse(url)
      conn = Net::HTTP.get_response(uri)
      resp= conn.body
      #resp = ActiveSupport::JSON.decode(resp)
     
    rescue Exception => e  
      
      tries += 1
      puts "Error: #{e.message}"
      puts "Trying again!" if tries <= 10
      retry if tries <= 10
      puts "No more attempt!"
	end
	
	return resp

end

 def getNextPageCommentHtml( url,  viewstate, eventtarget, eventargument, eventvalidation)
 
		#viewstate="/wEPDwUKLTI0NzY2MzkxMQ9kFgICAw9kFgQCAw9kFgJmD2QWAgIBDzwrAA0BAA8WBB4LXyFEYXRhQm91bmRnHgtfIUl0ZW1Db3VudAImZBYCZg9kFhQCAg9kFgJmD2QWAmYPFQYFMzggLSAHTW9oYW1hZAsxNS8wNy8yMDEyIAcgMTA6MTggEFRoZSBjb25zdGl0dXRpb27wAQ0KSSBzaW5jZXJlbHkgaG9wZSB0aGF0IHRoZSBtaWxpdGFyeSBsaXN0ZW4gdG8gdGhlIHdpbGwgb2YgdGhlIEVneXRwdGlhbiBwZW9wbGUgYW5kIGxldCB0aGUgbGVjZXRlZCBvZmZlY2lhbHMgZmluaXNoIHdyaXRpbmcgdGhlIGNvbnN0aXR1dGlvbiB0aGF0IHdpbGwgYnJpbmcgbW9yIGxpZ2l0aW1hY3kgYW5kIHJlc3BlY3QgdG8gdGhlIGFybXkgDQpHT0QgYmxlc3MgRWd5cHQgYW5kIHR5aGUgRWd5cHRpYW4gcGVvcGxlLmQCAw9kFgJmD2QWAmYPFQYFMzcgLSAe2YXYrdmF2YjYryDYudio2K8g2KfZhNmI2KfYrdivCzE1LzA3LzIwMTIgByAwMTo0MSA72K/Ys9iq2YjYsSDYp9mE2YXYt9in2KjYuSDYp9mE2KfZhdmK2LHZitmHINmK2KfYqNmE2KrYp9is2YnSAtmK2KjZgtmJINin2YTYqNmE2KrYp9is2Ykg2YHZiSDYp9mE2YTYrNmG2Ycg2KfZhNiq2KfYs9mK2LPZitmHINmI2KfZhNiv2LPYqtmI2LEg2YrYqtin2K7YsSDZg9mEINiv2Kcg2Iwg2YrYp9io2YTYqtin2KzZiSDYp9mG2Kog2LXYp9it2Kgg2K7YqNix2Ycg2KjYp9mE2YXYt9in2KjYuSDYp9mE2KfZhdmK2LHZitmHINmI2LLZiSDZhdin2K7ZhNi12Kog2KfZhNin2YbYqtiu2KfYqNin2Kog2KfZhNix2KbYp9iz2YrZhyDYrtmE2LUg2YTZhtinINin2YTYr9iz2KrZiNixINi52YTYtNin2YYg2YbYr9i52YrZhNmDINiMINmF2KfYqtmD2LPZgdi0INiu2YTYtSDZitin2KjZiCDYs9ixINio2KfYqti5ZAIED2QWAmYPZBYCZg8VBgUzNiAtIBTZitit2YrZiiAg2K3YrNin2LLZiQsxNS8wNy8yMDEyIAcgMDE6MDkgEtit2KzYp9iy2YrYp9iqICAhIc4H2YbYrdmGINmB2Yog2K3Yp9is2Kkg2KXZhNmKINir2YjYsdipINin2YTYo9iv2LHYp9isICEhLi4NCtmIINmE2YLYryDYsdij2YrZhtinINin2YTYr9mD2KrZiNixINin2YTYrNmG2LLZiNix2Ykg2YrZh9iv2K8g2KfZhNiv2YPYqtmI2LEg2LPYudivINin2YTZg9iq2KfYqtmG2Yog2KjYo9mGINmC2LHYp9ixINit2YQg2YXYrNmE2LMg2KfZhNi02LnYqCDZgdmKINiv2LHYrCDYp9mE2YXYrNmE2LMg2KfZhNi52LPZg9ix2Ykg2Ygg2KjYp9mE2YHYudmEINiu2LHYrCDYp9mE2YLYsdin2LEg2YXZhiDYp9mE2K/YsdisINiu2KfYsdis2Kcg2YTYs9in2YbZhyDZhNmE2LTYudioINin2YTZhdi12LHZiSDZg9mE2YcgLCDZiCDYp9mE2YrZiNmFINmG2LPZhdi5INij2YYg2YLYsdin2LEg2K3ZhCDYp9mE2YTYrNmG2Kkg2KfZhNiq2KPYs9mK2LPZitipINij2YrYttinINmB2Yog2K/YsdisINin2YTZhdis2YTYsyDYp9mE2LnYs9mD2LHZiSDYrtin2LXYqSDYqNi52K8g2KrZgtiv2YrZhSDYrNmE2LPYqSDYp9mE2YXYrdmD2YXYqSDZhdmGIDQg2LPYqNiq2YXYqNixINil2YTZiiAxNyDZitmI2YTZitmIINmE2YrZgdis2LEg2KfZhNit2YPZhSDYp9mE2LDZiSDZh9mIINmG2KfYptmFINmB2Yog2KfZhNij2K/Ysdin2Kwg2KfZhNit2YrYp9ipINin2YTYs9mK2KfYs9mK2Kkg2KjYsdmF2KrZh9inINmIINmG2LnZiNivINil2YTZiiDYp9mE2YXYsdio2Lkg2LXZgdixINil2YTYpyDYpdiw2Kcg2KPYqtiu2LAg2KfZhNiv2YPYqtmI2LEg2YXYsdiz2Yog2YXZhiDYp9mE2YLYsdin2LHYp9iqINmF2Kcg2YrZiNmC2YEg2YfYsNinINin2YTYudio2Ksg2KjZhdmC2K/Ysdin2Kog2KfZhNio2YTYryDYpdiz2KrZhtin2K/YpyDYudmE2Yog2K/YudmFINin2YTYtNi52Kgg2KfZhNmF2LXYsdmJINmE2Ycg2KjYudmK2K/YpyDYudmGINij2KjYp9i32YrZhCDYp9mE2LnZg9i02Kkg2Ygg2KfZhNio2YPYsdmJINmIINin2YTYr9ix2K/Zitix2YkgISFkAgUPZBYCZg9kFgJmDxUGBTM1IC0gE9mF2K3ZhdivINin2YTYs9mK2K8LMTUvMDcvMjAxMiAHIDExOjQ3IEfYrdmEINin2YTYqtij2LPZitiz2YrYqSDYs9mK2YLYp9io2YQg2KjYrdmEINin2YTZhdis2YTYsyDYp9mE2LnYs9mD2LHZiuAB2K3ZhCDYp9mE2KrYo9iz2YrYs9mK2Kkg2LPZitmC2KfYqNmEINio2K3ZhCDYp9mE2YXYrNmE2LMg2KfZhNi52LPZg9ix2YrYjCDZiNil2YTYutin2KEg2KfZhNin2LnZhNin2YYg2KfZhNiv2LPYqtmI2LHZiiAg2KfZhNmF2YPZhdmEINmI2K3ZhCDYp9mE2K/Ys9iq2YjYsdmK2Kkg2KjYp9iz2KrZgdiq2KfYoSDYtNi52KjZitmF2YYg2YfZiCDZhdix2LPZiiDYp9mE2LHYrNmEINin2YTYrNiv2LlkAgYPZBYCZg9kFgJmDxUGBTM0IC0gBGFkZWwLMTUvMDcvMjAxMiAHIDExOjQxIA7Yrtiy2LnYqNmE2KfYquwJ2YrYp9iz2KfYr9ipINmK2Kcg2KPZgdin2LbZhCDZh9mEINmH2KTZhNin2KEg2KfZhNit2LLYqNmK2YrZhiDZitmF2KvZhNmI2Kcg2KPZiiDYt9mK2YEg2YXZhiDYo9i32YrYp9mBINin2YTYtNi52Kgg2KfZhNmF2LXYsdmKINmB2YTYp9itINis2KfZhNizINi52YTZiSDZhdiz2LfYqNipINmB2Yog2LHZitmBINmF2LXYsSDYp9mE2YXYrdix2YjYs9ipINin2KrYrdiv2Ykg2KfZiiDZhdmGINmH2KTZhNin2KEg2KfZhNmF2KrYrdiv2KvZitmGINij2YYg2YrYrdiz2YYg2KfZhNmC2YjZhCDZhdir2YTZhyDZhdinINmH2LDYpyDZitin2LPYp9iv2Ycg2KfZhNiw2Yog2YrYsdmK2K8g2YLZiNin2KbZhSDZhNmE2YXYs9iq2YLZhNmK2YYg2YTYs9mH2YjZhNipINin2YTYt9i52YYg2KjYqNi32YTYp9mG2YfYpyDZiNin2YTYsNmKINmK2LHZitivINin2YTYpdi52KrYsdin2YEg2KjZhdmGINmE2Kcg2YrYudiq2LHZgdmI2YYg2KjZiNis2YjYryDYp9mE2YTZhyDZiNin2YTYsNmKINmK2LHZitivINmK2LHZitivINiy2YrYp9iv2Kkg2YXZhiDZitit2YIg2YTZh9mFINiz2YTYt9ipINin2YTYttio2LfZitipINin2YTZgti22KfYptmK2Kkg2YTZhNi02LnYqCDYp9mE2YXYrNix2YUg2YjYp9mE2LDZiiDZitix2YrYryDZgdix2LYg2LbYsdin2KbYqCDYqNin2YfYuNipINi52YTZiSDYp9mE2KPYutmG2YrYp9ihINmI2KfZhNiw2Yog2YrYsdmK2K8g2KPZhiDZitiz2KrZhdixINmB2Yog2KfZhNi52YXZhCDYrdiq2Ykg2YjZhNmIINiu2KfZhNmBINiw2YTZgyDYo9it2YPYp9mFINin2YTZgti22KfYoSDZg9mK2YEg2YrZg9mI2YYg2YfYpNmE2KfYoSDZh9mFINmF2YYg2YrYtNix2LnZiNmGINmE2YbYpyDYt9ix2YrZgtmG2Kcg2KfZhNmJINin2YTZhtmH2LbYqSDZiNin2YTYqtmG2YXZitipINmF2Kcg2YfYsNinINin2YTYstmF2YYg2KfZhNiw2Yog2YbYudmK2LQg2YHZitmHINmE2YLYryDYo9i12KjYrdmG2Kcg2YbYs9mF2Lkg2KPZhNmB2KfYuCDZiNis2YXZhCDYrdiq2Ykg2YXZhiDZgtin2YXYp9iqINiq2LnZhdmEINmB2Yog2KfZhNmC2LbYp9ihINmF2YYg2LPZhtmK2YYg2YjYs9mG2YrZhiDZh9mEINmH2LDYpyDYp9mE2YPZhNin2YUg2KfZhNmF2YbYs9mI2Kgg2YTZhNis2YbYqSDYp9mE2K3ZiNin2LEg2YjYp9mE2KfYqti12KfZhCDZiti12K/YsSDYudmGINmG2K7YqNipINmB2Yog2KfZhNmF2KzYqtmF2Lkg2KfZhNmF2LXYsdmKINin2LPZgdmKINi52YTZitmD2Yog2YrYp9mF2LXYsSDZiNit2LLZhtmKINmD2KjZitix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oCDZhdmE2YrZiNmGINmF2LXYsdmJygrYo9iv2LnZiCDZhNiq2KPYs9mK2LMg2KzZhdi52YrYqSDZhdmGIDgwINij2YTZgSDZhdmI2KfYt9mGINmF2YfZhdiq2YfYpyDYqtmF2KvZitmEINmE2YTYsdij2Ykg2KfZhNi52KfZhSDYjNij2Ykg2LHYo9mJIDgwINmF2YTZitmI2YYg2YXYtdix2Ykg2IzZitij2K7YsCDYqNix2KPZitmH2Kcg2YHZiSDZg9mEINmC2LHYp9ixINmK2YXYsyDYrdmK2KfYqSDYp9mE2YXYtdix2YrZitmGIA0K2LnZhdmE2YrYpyDZhNinINmK2YXZg9mGINij2K7YsCDYsdij2Ykg2KfZhNi02LnYqCDZg9mE2Ycg2YPZhNmF2Kcg2KPYsdiv2YbYpyDYpdiz2KrZgdiq2KfYptmHINiM2YjZhNmD2YYg2YTZiCDYo9iu2KrYsdmG2Kcg2YXZiNin2LfZhiDZhdmGINio2YrZhiDZg9mEINij2YTZgSDZhdmI2KfYt9mGINiz2YrZg9mI2YYg2YXZhiDYp9mE2LPZh9mEINil2LPYqti02KfYsdiq2YfZhSDYjCDZg9mEINmF2YjYp9i32YYg2YTZhiDZitmD2YjZhiDYsdij2YrZhyDZhdmGINiv2YXYp9i62Ycg2IzYqNmEINiz2YrZg9mI2YYg2YXZhNiy2YXYpyDYqNmF2LnYsdmB2Kkg2LHYo9mJINin2YTYo9mE2YEg2KfZhNiw2Ykg2YrZhdir2YTZh9mFINio2KfZhNin2LPZhSDYjNio2YXYudmG2Ykg2KPZhiDZitmG2YLZhCDYsdi62KjYqSDZhdmGINmK2YXYq9mE2YjZhyDYjNmI2YXZhiDYp9mE2LPZh9mEINin2YYg2YrYqti12YQg2KjZh9mFINmE2YXYudix2YHYqSDZhdi32KfZhNio2YfZhSDYjNmI2YfYsNinINmK2LTYqNmHINmF2KzZhNizINin2YTYtNi52Kgg2YjZhNmD2YYg2LPZitmD2YjZhiDYo9mD2KvYsSDYtdiv2YLYpyDZiNiq2YXYq9mK2YTYpyDZhNmE2LTYudioIDE2MCDZhdix2Kkg2IzZhNij2YbZhtinINmD2YXYpyDZhti52YTZhSDYo9mGINij2LnYttin2KEg2YXYrNmE2LMg2KfZhNi02LnYqCDZitmC2KrYsdio2YYg2YXZhiDYp9mE2LTYudioINmB2YLYtyDZgdmJINmF2YjYs9mFINin2YTYp9mG2KrYrtin2KjYp9iqINiM2YjZhNmD2YYg2YfYsNmHINin2KzZhdi52YrYqSDYs9iq2YPZiNmGINmF2LHYotipINmE2YXYpyDYrNix2Ykg2YHZiSDYp9mE2LTYudioINio2LTZg9mEICDYtdin2K/ZgiDYr9in2KbZhSDZiNmB2YjYsdmJINiM2YjYqNiw2YTZgyDZhNinINmK2K/YudmJINmD2YQg2LfYsdmBINiq2YXYq9mK2YQg2KfZhNi02LnYqCDZiNin2YTYtNi52Kgg2YXZhtmHINio2LHYpiDYjNij2LnZhNmFINij2YYg2KfZhNmB2YPYsdipINiu2YrYp9mE2YrYqSDZiNmF2KvYp9mE2YrYqSDYjNmI2YTZg9mGINmE2Ygg2LXYrdiqINin2YTZhtmI2YrYpyDZhNij2YXZg9mGINiq2YbZgdiw2YfYpyAg2KfZhNmF2YfZhtiv2LMg2YXYrdmF2YjYryDYudio2K/Yp9mE2K3ZhdmK2K8g2YXYrdmF2K8g2KjYqNin2LHZitizZAIJD2QWAmYPZBYCZg8VBgUzMSAtIBHYrNix2KzYsyDYrdmG2YrZhgsxNS8wNy8yMDEyIAcgMTA6NDEgJNin2YTYr9iz2KrZiNixINmF2LHYotipINin2YTYr9mI2YTYqaIR2YrYrNioINij2YYg2KrYtNmD2YQg2YTYrNmG2Kkg2YjYtti5INin2YTYr9iz2KrZiNixINmF2YYg2K7Yp9ix2Kwg2YXYrdmE2LPZiiDYp9mE2LTYudioINmI2KfZhNi02YjYsdmKINmI2KrYttmFINmD2KfZgdipINij2LfZitin2YEg2KfZhNmF2KzYqtmF2Lkg2KfZhNmF2LXYsdmKINmI2KrYqNiq2LnYryDYp9mE2YTYrNmG2Kkg2LnZhiDYp9mE2LnYqNin2LHYp9iqINin2YTZhdi32KfYt9ipINmB2KrZg9mI2YYg2KfZhNi12YrYp9i62Kkg2YjYp9i22K3YqSDZiNmE2YrYsyDZhNmH2Kcg2KrZgdiz2YrYsSDZgdil2YYg2KfZhNiq2YHYs9mK2LEg2YrZgdix2Lkg2KfZhNi12YrYp9i62Kkg2YXZhiDZhdi22YXZiNmG2YfYpyDZiNin2YTZhti1INin2YTZiNin2LbYrSDYudmE2Yog2K3ZgtmI2YIg2KzZhdmK2Lkg2KfZhNmF2YjYt9mG2YrZhiDZiNit2LHZitin2KrZh9mFINio2YXYpyDZhNinINmK2KTYq9ixINi52YTZiiDYrdix2YrYp9iqINin2YTYotiu2LHZitmGINmI2KrZhNi62Yog2YXYp9iv2Kkg2KfZhNmAIDUwICUg2YTZhNi52YXYp9mEINmI2KfZhNmB2YTYp9it2YrZhiDZiNmK2YPYqtmB2Yog2KjZhdis2YTYsyDYp9mE2LTYudioINiv2YjZhtmF2Kcg2K3Yp9is2Kkg2YTZhdis2YTYsyDYp9mE2LTZiNix2Yog2YjZitmD2YjZhiDZhti42KfZhSDYp9mE2KXZhtiq2K7Yp9io2KfYqiDYqNin2YTZgtin2KbZhdipINiv2YjZhtmF2Kcg2K3Yp9is2Kkg2YTZhNmB2LHYr9mKINmI2KfZhNmG2LUg2LnZhNmKINin2K3YqtmI2KfYoSDYp9mE2YLYp9im2YXYqSDYudmE2YogMTAgKNi52LTYsdipKSDYp9iz2YXYp9ihINiq2LbZhSDZiNin2K3YryDZitmF2KvZhCDYp9mE2YXYsdij2Kkg2YjZiNin2K3YryDZitmF2KvZhCDYp9mE2KPZgtio2KfYtyDZiNin2YTYqNin2YLZitmGINmK2YXYq9mE2YjZhiDYp9mE2LnZhdin2YQg2YjYp9mE2YHZhNin2K3ZitmGINmI2KfZhNi32YTYqNipINmI2KfZhNiq2KzYp9ixINmI2KfZhNi52YTZhdin2KEg2YjYp9mE2KPYr9io2KfYoSDZiNin2YTYudiz2YPYsdmK2YrZhiDZiNmD2KjYp9ixINin2YTYs9mGINmI2KrZhNiq2LLZhSDZg9mEINin2YTYo9it2LLYp9ioINmI2KfZhNmF2LPYqtmC2YTZitmGINio2YfYsNinINin2YTYqti02YPZitmEINmI2YbYqNi52K8g2YHZiiDYp9mE2K/Ys9iq2YjYsSDYudmGINin2YTZhdmI2KfYryDYp9mE2KXZgti12KfYptmK2Kkg2YjYp9mE2LnYqNin2LHYp9iqINin2YTYqtit2LHZiti22YrYqSDZiNin2YTZhNi62Kkg2KfZhNmF2LPYqtmB2LLYqSDZiNiq2KrZg9mI2YYg2YTYrNmG2Kkg2YjYtti5INin2YTYr9iz2KrZiNixINmF2YYgMjAwINi52LbZiCDZitiu2KrYp9ix2YjZhiDYqNin2YTYpdmG2KrYrtin2Kgg2KfZhNmF2KjYp9i02LEg2KjZiNin2LPYt9ipINix2KTYs9in2KEg2KfZhNij2K3Ystin2Kgg2YjZhdmF2KvZhNmK2YYg2LnZhiDZg9mEINi32YjYp9im2YEg2KfZhNmF2KzYqtmF2Lkg2YjYqtis2KrZhdi5INin2YTZhNis2YbYqSDYq9mE2KfYq9ipINij2YrYp9mFINmB2Yog2KfZhNij2LPYqNmI2Lkg2YTYtdmK2KfYutipINin2YTZhdmI2KfYryDYq9mFINmF2YbYp9mC2LTYqtmH2Kcg2YjYqtmD2YjZhiDZhNis2YbYqSDZiNi22Lkg2KfZhNiv2LPYqtmI2LEg2YXYtNiq2YXZhNipINi52YTZiiDZgtin2YbZiNmG2YrZitmGINmI2KPYr9io2KfYoSDZiNi52YTZhdin2KEg2YjZhtit2YjZitmK2YYg2YjYsdis2KfZhCDYr9mK2YYg2YjYsdis2KfZhCDYs9mK2KfYs9ipINmI2LHYrNin2YQg2YHZg9ixINmI2LTZitmI2K4g2YjYtNio2KfYqCDZhdmGINin2YTYsdis2KfZhCDZiNin2YTZhtiz2KfYoSDZiNmB2Yog2KfZhNij2YrYp9mFINin2YTYq9mE2KfYq9ipINin2YTYo9iu2LHZiiDYqti12KfYuiDYp9mE2YXZiNin2K8g2KfZhNmF2KrZgdmCINi52YTZitmH2Kcg2YjYqtiz2KrYsdmK2K0g2KfZhNmE2KzZhtipINmK2YjZhdinINmB2Yog2KfZhNij2LPYqNmI2Lkg2YjZhNinINmF2KfZhti5INmF2YYg2KfZhNil2LPYqti52KfZhtipINio2YXZhiDYqtix2Yog2KfZhNmE2KzZhtipINij2YYg2KrYs9mF2Lkg2LHYo9mK2Ycg2YjYqtiz2KrYutix2YIg2YfYsNmHINin2YTYudmF2YTZitipINmF2K/YqSDYq9mE2KfYq9ipINi02YfZiNixINmK2LnYsdi2INio2LnYr9mH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"
 		#viewstate="/wEPDwUKLTI0NzY2MzkxMQ9kFgICAw9kFgQCAw9kFgJmD2QWAgIBDzwrAA0BAA8WBB4LXyFEYXRhQm91bmRnHgtfIUl0ZW1Db3VudAImZBYCZg9kFhQCAg9kFgJmD2QWAmYPFQYFMzggLSAHTW9oYW1hZAsxNS8wNy8yMDEyIAcgMTA6MTggEFRoZSBjb25zdGl0dXRpb27wAQ0KSSBzaW5jZXJlbHkgaG9wZSB0aGF0IHRoZSBtaWxpdGFyeSBsaXN0ZW4gdG8gdGhlIHdpbGwgb2YgdGhlIEVneXRwdGlhbiBwZW9wbGUgYW5kIGxldCB0aGUgbGVjZXRlZCBvZmZlY2lhbHMgZmluaXNoIHdyaXRpbmcgdGhlIGNvbnN0aXR1dGlvbiB0aGF0IHdpbGwgYnJpbmcgbW9yIGxpZ2l0aW1hY3kgYW5kIHJlc3BlY3QgdG8gdGhlIGFybXkgDQpHT0QgYmxlc3MgRWd5cHQgYW5kIHR5aGUgRWd5cHRpYW4gcGVvcGxlLmQCAw9kFgJmD2QWAmYPFQYFMzcgLSAe2YXYrdmF2YjYryDYudio2K8g2KfZhNmI2KfYrdivCzE1LzA3LzIwMTIgByAwMTo0MSA72K/Ys9iq2YjYsSDYp9mE2YXYt9in2KjYuSDYp9mE2KfZhdmK2LHZitmHINmK2KfYqNmE2KrYp9is2YnSAtmK2KjZgtmJINin2YTYqNmE2KrYp9is2Ykg2YHZiSDYp9mE2YTYrNmG2Ycg2KfZhNiq2KfYs9mK2LPZitmHINmI2KfZhNiv2LPYqtmI2LEg2YrYqtin2K7YsSDZg9mEINiv2Kcg2Iwg2YrYp9io2YTYqtin2KzZiSDY"
        params = {
                  "__VIEWSTATE" => viewstate,
                  "__EVENTTARGET" => eventtarget, 
                  "__EVENTARGUMENT" => eventargument, 
                  "__EVENTVALIDATION"=> eventvalidation, 
                  "TxtBx_email"=> "",
                  "TxtBx_Name" => "",
                  "TxtBx_Title"=> "",
                  "TxtBxCmt"   => ""
                  }
        #jar = cookielib.CookieJar()
        #cookie = urllib2.HTTPCookieProcessor(jar)
        #opener = urllib2.build_opener(cookie)
        headers = {
                   "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
                   "Accept-Charset" => "ISO-8859-1,utf-8;q=0.7,*;q=0.3",
                   "Accept-Language" => "en-US,en;q=0.8",
                   "Content-type" => "application/x-www-form-urlencoded",
                   "Host"=> "www.ahram.org.eg",
                   #'Origin'=>'http://www.ahram.org.eg',
                   "User-Agent" => "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.202 Safari/535.1",
        }
		
		
	tries=0
	uri = URI.parse(url)
	begin
		#uri.query= URI.encode_www_form(params)
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout=3600
      http.open_timeout=3600
	  #conn = Net::HTTP.post_form(uri, params)
	#  params2= URI.escape(params)
		#puts ""
		
		#size=params2.bytesize
		#puts "params2 size isssss #{size}"
      request = Net::HTTP::Post.new(uri.request_uri)
	  puts "request uri issssss #{uri.request_uri}"
	  
	  #Could use cookies?? (faster?)
	  
	  #a=request.content_length()
	  #puts "a issssssss #{a}"
      #request.body=URI.encode_www_form(params)
	  #request.body=params
	  #request.set_form_data({"__VIEWSTATE" => viewstate, "__EVENTTARGET" => eventtarget,  "__EVENTVALIDATION"=> eventvalidation})
	  request.set_form_data(params)
	  puts "request data issssss #{request.body}"
      request.add_field("Accept" , "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
	  request.add_field("Accept-Charset" , "ISO-8859-1,utf-8;q=0.7,*;q=0.3")
	  request.add_field( "Accept-Language", "en-US,en;q=0.8")
	  
	  request.add_field("Content-type" , "application/x-www-form-urlencoded")
	  #request.add_field("transfer-encoding", "chunked")
	  #request.add_field("Content-length" , size)
	  request.add_field("Host", "www.ahram.org.eg")
	  request.add_field('Origin','http://www.ahram.org.eg')
	  request.add_field("User-Agent" , "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.202 Safari/535.1")	  	  
	  pp "request is #{request}"
	  #CONTINUEEEEE HEREEEEE
	  
	  response= http.request(request)
      resp=response.body
	  #headers= response.headers
	  #puts "response headers are #{headers}"
	  puts "resp is!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	  puts resp
      #resp = ActiveSupport::JSON.decode(resp)
    rescue Exception => e  
        tries += 1
        puts "Error: #{e.message}"
        puts "Trying again analyze!" if tries <= 3
        retry if tries <= 3
        puts "No more attempts in analyzing!"  
    end
		
		return resp
		
  end    

def searchForNextPageComment(html, url, nextPage)
	value_pattern = 'value="[^\^]*?"'
	next_page_pattern = "javascript:__doPostBack('GdVwComments','Page$#{nextPage}')" 
	next_page = html.index(next_page_pattern)
	puts "next page issss #{nextPage}"
	
	if !next_page.nil?
            idx = html.index("__VIEWSTATE")
            viewstate = html[idx .. html.index(">", idx)-1]
            viewstate =  viewstate.scan(/#{value_pattern}/)[0]
            viewstate = viewstate[viewstate.index('"') + 1 .. viewstate.rindex('"')-1]
            
            idx = html.index("__EVENTVALIDATION")
            eventvalidation = html[idx .. html.index(">", idx)-1]
            eventvalidation =  eventvalidation.scan(/#{value_pattern}/)[0]
            eventvalidation = eventvalidation[eventvalidation.index('"') + 1 .. eventvalidation.rindex('"')-1]
            
            eventtarget = next_page_pattern[next_page_pattern.index("'") + 1 .. next_page_pattern.index(",") - 2]
            eventargument = "Page$#{nextPage}" 
            
			puts "viewstate STOP#{viewstate}STOP eventvalidation #{eventvalidation} EVENTTARGET #{eventtarget} EVENTARGUMENT #{eventargument}"
			#html="hey"
            html = getNextPageCommentHtml(url, viewstate, eventtarget, eventargument, eventvalidation)
        else
            html = ''
		end
        return html

end


def getComments(theid)
comments=[]
comment_url="http://www.ahram.org.eg/ViewComments.aspx?ContentID=#{theid}"
comment_html= html_getter(comment_url)
puts "comment html issss #{comment_html}"
nextPage=2
pattern_comment = '<div class="commenttext">[^\^]*?<\/div>'
while comment_html != '' do
	raw_comments=comment_html.scan(/#{pattern_comment}/)
	raw_comments.each do |c|
		#puts c
		c = c[c.index("<br />")+6..c.index("</div>")-1]
		#c['<br>']='\n'
		puts c
		z=c.scan(/[a-zA-Z]+/)
		#print z
		if z.length>5
			print "ENGLISH"
		else
		#break
		  puts "encoding wassss #{c.encoding}" #was ascii!!
			comments<<c.force_encoding("utf-8")
			puts "now encoding isss #{c.encoding}" # now utf-8, otherwise sentiment analyzer won't understand it.
		end
	end
	#break
	comment_html = searchForNextPageComment(comment_html, comment_url, nextPage)
	nextPage += 1
	#break	
end
#return comments
  puts "There are #{comments.length} comments found in Ahram"
  analyzeComments(comments)
end

def analyzeComments(comments)  #Not Threaded
    uri = URI.parse("http://omp.sameh.webfactional.com/taggingList")
    #uri = URI.parse("http://names.alwaysdata.net/taggingList")
    comments2=comments
    while !comments2.nil? and !comments2.empty? do
    tries=0
    to_tag_json = ActiveSupport::JSON.encode(comments2[0,100])
    post_body = to_tag_json
    begin
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout=3600
      http.open_timeout=3600
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = post_body
      response= http.request(request)
      resp=response.body
      resp = ActiveSupport::JSON.decode(resp)
    rescue Exception => e  
        tries += 1
        puts "Error: #{e.message}"
        puts "Trying again analyze!" if tries <= 3
        retry if tries <= 3
        puts "No more attempts in analyzing!"  
    end
    
    puts "resp size isss #{resp.length}"
    puts "cmomments size isss #{comments2[0,100]}"
    
    if !resp.nil? and !resp.empty? and resp.kind_of?(Array) and resp.length==comments2[0,100].length
      puts "over hereeeee"
      comments2[0,100].zip(resp).each do |l, a|
        @c= Comment.create(:article_id =>@aid , :comment => l, :coloured_comment => a[0], :polarity => a[1])
      end
    end
    #puts "resp wwasssss : #{resp}"
    #if !resp.nil? and resp.kind_of?(Array)
    #  puts "size of resppp is #{resp.length}"
    #end
    comments2=comments2[100..comments2.length]
    
    end
  end



end

#comments=getComments()

#puts "Comments are #{comments.length}"
#comments.each do |c|
#	puts c
#end


