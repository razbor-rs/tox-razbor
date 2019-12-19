meta: {
    id: "tox_protocol"
    title: "Tox protocol"
    license: "MIT"
}

seq: [
    {
        id: "packet_kind",
        type: "u1",
        enum: id
    },
    {
        id: "packet_payload"
        type: {
            "switch-on": "packet_kind"
            cases: {
                "packet_kind::ping_request": "ping_request"
                "packet_kind::ping_response": "ping_response"
                "packet_kind::node_request": "node_request"
                "packet_kind::node_response": "node_response"
                "packet_kind::cookie_request": "cookie_request"
                "packet_kind::cookie_response": "cookie_response"
                "packet_kind::crypto_handshake": "crypto_handshake"
                "packet_kind::crypto_data": "crypto_data"
                "packet_kind::dht_request": "dht_request"
                "packet_kind::lan_discovery": "lan_discovery"
                "packet_kind::onion_request_0": "onion_request_0"
                "packet_kind::onion_request_1": "onion_request_1"
                "packet_kind::onion_request_2": "onion_request_2"
                "packet_kind::announce_request": "announce_request"
                "packet_kind::announce_response": "announce_response"
                "packet_kind::onion_data_request": "onion_data_request"
                "packet_kind::onion_data_response": "onion_data_response"
                "packet_kind::onion_response_3": "onion_response_3"
                "packet_kind::onion_response_2": "onion_response_2"
                "packet_kind::onion_response_1": "onion_response_1"
                "packet_kind::bootstrap_info": "bootstrap_info"
            }
        }
    }
]

public_key :: {
    id: "public_key"
    size: 32
}

nonce :: {
    id: "nonce"
    size: 24
}

types: {
    ping_request: seq: [
        public_key,
        nonce,
        { id: "payload", size: 25 }
    ]

    ping_response: seq: [
        public_key, nonce,
        { id: "payload", size: 25 }
    ]

    nodes_request: seq: [
        public_key, nonce,
        { id: "payload", size: 56 }
    ]

    nodes_response: seq: [
        public_key, nonce,
        { id: "number", type: "u1" },
        { id: "payload", "size-eos": true }
    ]

    cookie_request: seq: [
        public_key, nonce,
        { id: "payload", size: 88 }
    ]

    cookie_response: seq: [
        nonce,
        { id: "payload", size: 136 }
    ]

    crypto_handshake: seq: [
        { id: "cookie_nonce", size: 24 },
        { id: "cookie", size: 88 },
        { id: "payload_nonce", size: 24 },
        { id: "payload", size: 248 },
    ]

    crypto_data: seq: [
        { id: "nonce_last_two", size: 2 },
        { id: "payload", "size-eos": true },
    ]

    dht_request: seq: [
        { id: "receiver_pk", size: 32 },
        { id: "sender_pk", size: 32 },
        nonce,
        { id: "payload", "size-eos": true },
    ]

    lan_discovery: seq: [
        public_key
    ]

    onion_request_0: seq: [
        nonce, public_key,
        { id: "payload", "size-eos": true },
    ]

    onion_request_1: seq: [
        nonce, public_key,
        { id: "payload", size: "_io.size - _io.pos - onion_return._sizeof" },
        { id: "onion_return", "size": 59 },
    ]

    onion_request_2: seq: [
        nonce, public_key,
        { id: "payload", size: "_io.size - _io.pos - onion_return._sizeof" },
        { id: "onion_return", "size": 118 },
    ]

    announce_request: seq: [
        nonce, public_key,
        { id: "payload", "size-eos": true },
    ]

    announce_response: seq: [
        { id: "sendback", type: "u8" },
        nonce,
        { id: "payload", "size-eos": true },
    ]

    onion_data_request: seq: [
        { id: "destination_pk", size: 32 },
        nonce,
        { id: "temporary_pk", size: 32 },
        { id: "payload", "size-eos": true },
    ]

    onion_data_response: seq: [
        nonce, public_key,
        { id: "payload", "size-eos": true },
    ]

    onion_response_3: seq: [
        { id: "onion_return", "size": 177 },
        { id: "payload", "size-eos": true },
    ]

    onion_response_2: seq: [
        { id: "onion_return", "size": 118 },
        { id: "payload", "size-eos": true },
    ]

    onion_response_1: seq: [
        { id: "onion_return", "size": 59 },
        { id: "payload", "size-eos": true },
    ]

    bootstrap_info: seq: [
        { id: "version", type: "u4" },
        { id: "motd", "size-eos": true }, // 256 max
    ]
}

enums: packet_kind: {
    "0x00": "ping_request"
    "0x01": "ping_response"
    "0x02": "nodes_request"
    "0x04": "nodes_response"
    "0x18": "cookie_request"
    "0x19": "cookie_response"
    "0x1a": "crypto_handshake"
    "0x1b": "crypto_data"
    "0x20": "dht_request"
    "0x21": "lan_discovery"
    "0x80": "onion_request_0"
    "0x81": "onion_request_1"
    "0x82": "onion_request_2"
    "0x83": "announce_request"
    "0x84": "announce_response"
    "0x85": "onion_data_request"
    "0x86": "onion_data_response"
    "0x8c": "onion_response_3"
    "0x8d": "onion_response_2"
    "0x8e": "onion_response_1"
    "0xf0": "bootstrap_into"
}
