# cython: language_level=3, boundscheck=True, wraparound=False, initializedcheck=False
cimport cython

cimport numpy as np
import numpy as np
from libc.math cimport pow


def recalculate_data(np.ndarray np_data, np.ndarray np_clusters):
    cdef long k = np.unique(np_clusters).max()
    cdef long n = np_data.shape[0], m = np_data.shape[1]
    cdef long i = 0, j = 0
    cdef double [:,:] data = np_data
    cdef long [:] clusters = np_clusters.astype(np.int64)
    cdef double [:,:] res = np.ones((k, m))
    cdef long [:] clusters_sizes = np.zeros(k, dtype=np.int64)

    for i in range(n):
        clusters_sizes[clusters[i] - 1] += 1
        for j in range(m):
            res[clusters[i] - 1][j] *= data[i][j]

    for i in range(k):
        for j in range(m):
            res[i][j] = pow(res[i][j], 1 / clusters_sizes[i])
    return np.array(res)


def recalculate_returns(np.ndarray np_returns, np.ndarray np_clusters):
    cdef long k = np.unique(np_clusters).max()
    cdef long n = np_returns.shape[0]
    cdef long i = 0
    cdef double [:] returns = np_returns
    cdef long [:] clusters = np_clusters.astype(np.int64)
    cdef double [:] res = np.ones((k,))
    cdef long [:] clusters_sizes = np.zeros(k, dtype=np.int64)

    for i in range(n):
        clusters_sizes[clusters[i] - 1] += 1
        res[clusters[i] - 1] *= returns[i]

    for i in range(k):
        res[i] = pow(res[i], 1 / clusters_sizes[i])
    return np.array(res)
