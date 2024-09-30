import json
import os
from enum import Enum, auto

from pydantic import BaseModel

user_message = "I would like to order pizza for two, with mushrooms and extra cheese"


class Metric(Enum):
    items_sold = auto()
    items_ordered = auto()
    items_bought = auto()
    items_stored = auto()
    items_shipped = auto()


def return_metric(metric: str) -> Metric:
    """Return a metric for a given metric"""
    return Metric(metric)


# Starting main script. User's initial message
initial_message = {"role": "user", "content": "Given the following question, return the appropriate metric"}

tools = [
    {
        "type": "function",
        "function": {
            "name": return_metric.__name__,
            "description": return_metric.__doc__,
            "parameters": {
                "type": "object",
                "properties": {
                    "metric": {
                        "type": "string",
                        "enum": [m.name for m in Metric],
                        "description": "metric value to return",
                    },
                },
            },
        },
    },
]

import ollama

response = ollama.chat(
    model="llama3.2",
    messages=[
        {
            "role": "user",
            "content": "Given the following question, return the appropriate metric: \n how many items were sold last year ",
        },
    ],
    stream=False,
    tools=tools,
)

print(response)
