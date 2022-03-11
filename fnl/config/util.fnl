(module config.util)

(fn table.key? [self k] (~= nil (. self k)))
