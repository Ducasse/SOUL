Encapsulates compiledMethods as logic terms to be used in the LiCoR rules. We have two reasons for implementing this special term to represent methods inside LiCoR:

* optimization: Using compiledmethods instead of source or parsetrees allows us to extract some information at high speeds (such as abstract, messages send, etc....)
* if the actual method changes in the image, our term automatically *will* be updated with the new compiledmethod
