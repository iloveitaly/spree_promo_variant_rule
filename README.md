Spree Promotion Variant Rule
============================

Currently with spree core you can select products to be included in a promotion, but you can't select specific variants of products.

This extension adds this functionality. However, right now there is no GUI for adding variants. You have to add them manually through the command line.

Eventually I'd like to see this functionality [merged into spree core](https://github.com/spree/spree/issues/2272) but I don't have the time to create the PR right now.

Adding Products on the Command Line
-----------------------------------

This is ugly hack for not having the time to write a proper GUI for this. Create the promotion, open up the rails console, then:

```
# find the promotion; use the ID in the admin URL
p = Spree::Promotion.find(8)

# get your list of variants
variants = [Spree::Variant.last]

# assuming you only have one rule
p.rules.first.variants = variants
```


Copyright (c) 2012 Michael Bianco, released under the New BSD License
