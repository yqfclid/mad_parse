## fault parse 

### usage
* add following option to compile flags
```
    {parse_transform, mad_parse}
```
* then it will transform os:timestamp/0 to {0, 0, 0}
