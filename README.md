# _Lakes_: A _Simply ReSTful_ demo application

Here is a sample application, implemented with the [SimplyReSTful](https://github.com/gabrielbazan/simply-restful) framework.

And it is a very simple one. Its business logic is the following: 
A country has states, and a state has lakes.


## The API

So, the API has three endpoints:
 * /countries
 * /states
 * /lakes

And on each one of them we can create, list, update and delete those resources.

Resources are represented using JSON (JavaScript Object Notation), so when you send a 
request body (POST and PUT HTTP methods) to the server, you must send the 
_Content-type: Application/json_ header.

Let's see how we can do it.

### Countries

Countries can be managed under the _/countries_ endpoint.

#### Create a new Country

Using the HTTP POST method, you simply have to send a content like this:

```json
{
  "name": "United States of America"
}
```

And you'll get a response like this:

```json
{
    "id": 1,
    "name": "United States of America",
    "created": "2018-10-27T02:45:52.519538Z"
}
```

#### List Countries

Using the HTTP GET method over its endpoint, you will retrieve a list of all the existent 
countries. So, you'll get a response like this:

```json
{
    "count": 1,
    "results": [
        {
            "id": 1,
            "name": "United States of America",
            "created": "2018-10-27T02:45:52.519538Z"
        }
    ]
}
```

You can even apply [filters and pagination](#filtering-and-pagination).

#### Read a Country

Using the HTTP GET method over the _/countries/{id}_ endpoint, you can request an specific
country by its identifier and retrieve something like this:

```json
{
    "id": 1,
    "name": "United States of America",
    "created": "2018-10-27T02:45:52.519538Z"
}
```

#### Update a Country

Using the HTTP PUT method over the _/countries/{id}_ endpoint, you can update an specific country
by its identifier, and sending a content like the following:

```json
{
    "name": "Australia"
}
```

And you'll get a response like this one:

```json
{
    "id": 1,
    "name": "Australia",
    "created": "2018-10-27T02:45:52.519538Z"
}
```

#### Delete a Country

Using the HTTP DELETE method over the _/countries/{id}_ endpoint, you can delete an specific country
by its identifier. You'll know it has been deleted, because the service will respond with the 
_204 HTTP code (No Content)_.

You can't delete a country if there are States that belong to the country you are trying to delete.


## Filtering, Ordering and Pagination

Filtering and pagination can be applied using URL parameters.

### Filtering

Simply-restful has a very complete and automatic filtering system you can use though URL parameters.

Each parameter applies a filter over an specific resource propery, and is formed as **{property_name}__{operation}={value}**, where:
 * **property_name** is the name of the resource property (the column, on the database) over which you're applying the filter.
 * **operation** is one of: "eq", "gt", "ge", "lt", "le", "in", "notin", "like", "notlike", "ilike", "notilike", "is", "isnot", "intersects", "contains". "intersects" and "contains" are geometric operations. 
 * **value** is ... the value.

Examples:
```
{url}/countries?id__eq=1
{url}/countries?id__in=1;2
{url}/countries?id__gt=3&name__like=%America%&id__notin=6;8;10
```

### Ordering

Using the _order_by_ URL parameter you can specify how to order the list resource.

By default ordering is ascending (see the first example), and you can specify multiple columns. Ordering is applied from left to right.

Examples:
```
{url}/countries?order_by=id

{url}/countries?order_by=id__desc

{url}/countries?order_by=name__desc;id__asc
```

### Pagination

Using the _limit_ and _offset_ URL parameters you can handle the pagination. Also, list resources provide a _count_ property.

Example:
```
{url}/countries?limit=10&offset=20
```

On the [settings.py](simplyrestful-demo/app/settings.py) you can configure:
 * The default quantity of results per page, using the _DEFAULT_PAGE_SIZE_ setting.
 * And the maximum quantity of results per page, using the _MAX_PAGE_SIZE_ setting.
