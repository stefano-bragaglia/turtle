import heapq
import time
from datetime import datetime


class KeyHeapq(object):
    """ Class for the representation of a priority queue with a specified sorting function. """

    @staticmethod
    def heapify(items):
        return KeyHeapq(initial=items)

    def __init__(self, initial=None, key=lambda x: x):
        self.__key = key
        if initial:
            self._data = [(key(item), item) for item in initial]
            heapq.heapify(self._data)
        else:
            self._data = []

    def heappush(self, item):
        heapq.heappush(self._data, (self.__key(item), item))

    def heappop(self):
        return heapq.heappop(self._data)[1]

    def __iter__(self):
        for (key, item) in self._data:
            yield item

    def __len__(self):
        return len(self._data)

    def __str__(self):
        return str(map(lambda x: x[1], self._data))

    def __repr__(self):
        return str(self)


class Timer:
    """ Class for the evaluation of performance. """

    def __enter__(self) -> 'Timer':
        self._start = time.time()

        return self

    def __exit__(self, *args) -> None:
        self.end = time.clock()
        self.interval = self.end - self._start

    def __repr__(self) -> str:
        return f"Elapsed: {datetime.fromtimestamp(time.clock() - self._start).time().isoformat()}"

    @property
    def start(self) -> float:
        return self._start


if __name__ == '__main__':
    x = KeyHeapq()
    x.heappush(5)
    x.heappush(3)
    x.heappush(7)

    print(len(x))
    print(x)
