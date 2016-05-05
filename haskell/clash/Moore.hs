module Moore where
import CLaSH.Prelude

mac s (x,y) = s + x*y

topEntity = moore mac id 0