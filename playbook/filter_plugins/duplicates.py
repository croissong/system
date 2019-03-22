from copy import deepcopy

def reduce(list, reducer, initial={}):
    reducer = eval(reducer)
    total = deepcopy(initial)
    for i, val in enumerate(list):
        total = reducer(total, val, i, list)
    return total

def reduce_dict(dict, reducer, initial={}):
    reducer = eval(reducer)
    total = deepcopy(initial)
    for key, val in dict.items():
        total = reducer(total, key, val, dict)
    return total

def map_lambda(collection, mapper):
    mapper = eval(mapper)
    return [mapper(val, i, collection) for i, val in enumerate(collection)]


class FilterModule(object):
    '''
    custom jinja2 filters for working with collections
    '''

    def filters(self):
        return {
            'reduce': reduce,
            'reduce_dict': reduce_dict,
            'map_lambda': map_lambda
        }
