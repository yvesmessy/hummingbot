# distutils: language=c++

from libc.stdint cimport int64_t
from libcpp.set cimport set
from libcpp.vector cimport vector
cimport numpy as np
from .OrderBookEntry cimport OrderBookEntry
from .pubsub cimport PubSub

cdef class OrderBook(PubSub):
    cdef set[OrderBookEntry] _bid_book
    cdef set[OrderBookEntry] _ask_book
    cdef int64_t _snapshot_uid
    cdef int64_t _last_diff_uid
    cdef double _best_bid
    cdef double _best_ask

    cdef c_apply_diffs(self, vector[OrderBookEntry] bids, vector[OrderBookEntry] asks, int64_t update_id)
    cdef c_apply_snapshot(self, vector[OrderBookEntry] bids, vector[OrderBookEntry] asks, int64_t update_id)
    cdef c_apply_trade(self, object trade_event)
    cdef c_apply_numpy_diffs(self,
                             np.ndarray[np.float64_t, ndim=2] bids_array,
                             np.ndarray[np.float64_t, ndim=2] asks_array)
    cdef c_apply_numpy_snapshot(self,
                                np.ndarray[np.float64_t, ndim=2] bids_array,
                                np.ndarray[np.float64_t, ndim=2] asks_array)
    cdef double c_get_price(self, bint is_buy) except? -1
    cdef double c_get_price_for_volume(self, bint is_buy, double volume) except? -1
    cdef double c_get_price_for_quote_volume(self, bint is_buy, double quote_volume) except? -1
    cdef double c_get_volume_for_price(self, bint is_buy, double price) except? -1
    cdef double c_get_quote_volume_for_price(self, bint is_buy, double price) except? -1
    cdef double c_get_vwap_for_volume(self, bint is_buy, double volume) except? -1
    cdef double c_get_quote_volume_for_base_amount(self, bint is_buy, double base_amount) except? -1
